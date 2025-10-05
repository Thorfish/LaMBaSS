/// @description Insert description here
// You can write your code in this editor
var card_spread = 30

if clicked {
	y = lerp(y, mouse_y+100, 0.1)
	x = lerp(x, mouse_x, 0.1)
	image_angle = lerp(image_angle, 0, 0.1)
} else if discarded {
	var num_of_discarded = 0
	with obj_card {
		if discarded {
			num_of_discarded += 1
		}
	}
	x = lerp(x, room_width/2 - (num_of_discarded/2)*card_spread*5.5 - 100 + position*card_spread*5.5, 0.1)
	y = lerp(y, 250,0.1)
	image_angle = lerp(image_angle, 0, 0.1)
} else {
	y = lerp(y, room_height+100-hovered*100, 0.1)
	x = lerp(x, room_width/2 - (hand_controller.number_of_cards/2)*card_spread + position*card_spread, 0.1)
	image_angle = lerp(image_angle, -(position-hand_controller.number_of_cards/2)*10-5, 0.1)
}

if mouse_x < (bbox_left+bbox_right)/2+20 && mouse_x > (bbox_left+bbox_right)/2-20 && !discarded {
	if mouse_y > room_height*0.8 || clicked {
		with (obj_card) {
			hovered = false	
		}
		hovered = true
		if !audio {
			audio_play_sound(card_sound1, 1,false,1,0,random_range(0.8,1.2))
			audio = true
		}
	}
} else {
	hovered = false	
	audio = false
}

if hovered {
	depth = -1
	if (mouse_check_button(mb_left)) {
		var clicked_ = 0
		with obj_card {
			if clicked { clicked_ += 1 }
		}
		
		if !(clicked_ > 0) {
			clicked = true
		}
	} else {
		clicked = false	
	}
} else {
	depth = depth_
}

if y < room_height/2+150 && !discarded {
	active = true 	
} else {
	active = false	
}

if active && !clicked && battle_controller.player_card_total + effect.card_cost <= 3 {
	discarded = true
	active = false
	with (obj_card) {
		if position > other.position && !discarded {
			position -= 1
		}
	}
	hand_controller.number_of_cards-=1
	array_push(battle_controller.player_cards, effect)
	battle_controller.player_card_total += effect.card_cost
	var num_of_discarded = 0
	with obj_card {
		if discarded {
			num_of_discarded += 1
		}
	}
	position = num_of_discarded
}

if discarded && mouse_x < bbox_right && mouse_x > bbox_left && mouse_y < bbox_bottom && mouse_y > bbox_top {
	active = true
	if mouse_check_button_pressed(mb_left) {
		active = false
		clicked = false
		//add the card back to ur hand
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
		
		// Immediately move the card back to hand area to prevent re-discarding
		y = room_height + 100

		//reset the positions of every discarded card
		var i = 1
		with obj_card {
			if discarded {
				position = i
				i += 1
			}
		}
	}
}