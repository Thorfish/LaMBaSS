/// @description Card Step Event - Handles card positioning, interaction, and state management
// This event controls the visual positioning and behavior of cards in the player's hand

// Define the spacing between cards in the hand
var card_spread = 30

// CARD POSITIONING LOGIC
// Handle different card states: clicked (being dragged), in play, or normal hand position
if clicked {
	// When card is clicked/dragged, follow mouse with slight offset
	y = lerp(y, mouse_y+100, 0.1)
	x = lerp(x, mouse_x, 0.1)
	image_angle = lerp(image_angle, 0, 0.1)
} else if discarded {
	// When card is in play, arrange in play area at top
	var num_of_discarded = 0
	with obj_card {
		if discarded {
			num_of_discarded += 1
		}
	}
	// Position played cards in a horizontal line at the top
	x = lerp(x, room_width/2 - (num_of_discarded/2)*card_spread*5.6 - 95 + position*card_spread*5.6, 0.1)
	y = lerp(y, 500,0.1)
	image_angle = lerp(image_angle, 0, 0.1)
} else {
	// Normal hand position - cards arranged in a fan pattern at bottom of screen
	y = lerp(y, room_height+100-hovered*100, 0.1)  // Hovered cards move up slightly
	x = lerp(x, room_width/2 - (hand_controller.number_of_cards/2)*card_spread + position*card_spread, 0.1)
	// Create fan effect by rotating cards based on their position
	image_angle = lerp(image_angle, -(position-hand_controller.number_of_cards/2)*10-5, 0.1)
}

// MOUSE HOVER DETECTION
// Check if mouse is over this card (within 20 pixels of center) and card is not in play
if mouse_x < (bbox_left+bbox_right)/2+20 && mouse_x > (bbox_left+bbox_right)/2-20 && !discarded {
	// Only hover if mouse is in lower 20% of screen or card is clicked
	if mouse_y > room_height*0.8 || clicked {
		// Clear hover state from all other cards
		with (obj_card) {
			hovered = false	
		}
		// Set this card as hovered
		hovered = true
		// Play hover sound effect (only once per hover)
		if !audio {
			audio_play_sound(card_sound1, 1,false,1,0,random_range(0.8,1.2))
			audio = true
		}
	}
} else {
	// Mouse not over card, clear hover state and audio flag
	hovered = false	
	audio = false
}
// CLICK HANDLING AND DEPTH MANAGEMENT
if hovered {
	// Bring hovered card to front by setting very high depth
	depth = -room_width
	// Check for left mouse button press
	if (mouse_check_button(mb_left)) {
		// Count how many cards are currently clicked
		var clicked_ = 0
		with obj_card {
			if clicked { clicked_ += 1 }
		}
		
		// Only allow clicking if no other card is already clicked
		if !(clicked_ > 0) {
			clicked = true
		}
	} else {
		// Mouse button released, stop clicking
		clicked = false	
	}
} else {
	// Set depth based on x position for proper layering in hand
	depth = -x
}

// CARD ACTIVATION LOGIC
// Card becomes active when moved to upper half of screen and not in play
if y < room_height/2+200 && !discarded {
	active = true 	
} else {
	active = false	
}

// Debug output for troubleshooting
show_debug_message("active: " + string(active) + " clicked: " + string(clicked) + " battle_controller.player_card_total: " + string(battle_controller.player_card_total) + " effect.card_cost: " + string(effect.card_cost))

// AUTO-PLAY LOGIC
// Automatically play card when it becomes active, not clicked, and within cost limit
if active && !clicked && battle_controller.player_card_total + effect.card_cost <= 3 {
	// Mark card as in play
	discarded = true
	active = false
	
	// Adjust positions of remaining cards in hand
	with (obj_card) {
		if position > other.position && !discarded {
			position -= 1
		}
	}
	
	// Update hand controller and battle controller
	hand_controller.number_of_cards-=1
	array_push(battle_controller.player_cards, effect)
	battle_controller.player_card_total += effect.card_cost
	
	// Count played cards and set this card's position in play area
	var num_of_discarded = 0
	with obj_card {
		if discarded {
			num_of_discarded += 1
		}
	}
	position = num_of_discarded
}

// PLAY AREA INTERACTION
// Allow clicking on played cards to return them to hand
if discarded && mouse_x < bbox_right && mouse_x > bbox_left && mouse_y < bbox_bottom && mouse_y > bbox_top {
	active = true
	// Check for mouse click on played card
	if mouse_check_button_pressed(mb_left) {
		active = false
		clicked = false
		
		// Return card to hand
		discarded = false
		hand_controller.number_of_cards += 1
		
		// Remove this card's effect from battle_controller.player_cards
		var effect_index = array_get_index(battle_controller.player_cards, effect)
		if effect_index >= 0 {
			array_delete(battle_controller.player_cards, effect_index, 1)
		}
		
		// Reduce the card counter on battle_controller
		battle_controller.player_card_total -= effect.card_cost
		
		// Set position to be at the end of the hand
		position = hand_controller.number_of_cards - 1
		
		// Immediately move the card back to hand area to prevent re-playing
		y = room_height + 100

		// Reset the positions of every remaining played card
		var i = 1
		with obj_card {
			if discarded {
				position = i
				i += 1
			}
		}
	}
}

