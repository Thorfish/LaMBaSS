/// @description Insert description here
// You can write your code in this editor
var card_spread = 30

if clicked {
	y = lerp(y, mouse_y+100, 0.1)
	x = lerp(x, mouse_x, 0.1)
	image_angle = lerp(image_angle, 0, 0.1)
} else if discarded {
	x = lerp(x, room_width-100,0.1)
	y = lerp(y, room_height-10,0.1)
	image_angle = lerp(image_angle, 0, 0.1)
} else {
	y = lerp(y, room_height+100-hovered*100, 0.1)
	x = lerp(x, room_width/2 - (hand_controller.number_of_cards/2)*card_spread + position*card_spread, 0.1)
	image_angle = lerp(image_angle, -(position-hand_controller.number_of_cards/2)*10-5, 0.1)
}

if mouse_x < (bbox_left+bbox_right)/2+20 && mouse_x > (bbox_left+bbox_right)/2-20 && !discarded {
	with (obj_card) {
		hovered = false	
	}
	hovered = true
	if !audio {
		audio_play_sound(card_sound1, 1,false,1,0,random_range(0.8,1.2))
		audio = true
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
	image_index = 1 	
} else {
	image_index = 0	
}

if image_index == 1 && !clicked {
	discarded = true
	image_index = 0
	with (obj_card) {
		if position > other.position {
			position -= 1
		}
	}
	hand_controller.number_of_cards-=1
}