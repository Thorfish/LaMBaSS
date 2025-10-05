/// @description Insert description here
// You can write your code in this editor
if clicked {
	x = lerp(x, mouse_x, 0.1)
	y = lerp(y, mouse_y+60, 0.1)
} else if in_deck {
	x = lerp(x, 400 + (index mod 5)*115, 0.1)
	var y_val = floor(index/5)*110
	y = lerp(y, 190 + y_val, 0.1)
} else {
	x = lerp(x, 100 + (index mod 2)*115, 0.1)
	var y_val = floor(index/2)*110
	y = lerp(y, 190 + y_val, 0.1) + scroll_offset
}

if mouse_check_button_pressed(mb_left) && active {
	clicked = true	
} else if mouse_check_button_released(mb_left) {
	if in_deck && x < 300 {
		in_deck = false	
	} else if !in_deck && x > 300 {
		in_deck = true	
	}
	//reset the positions of every discarded card
	var i = 0
	with obj_mini_card {
		if in_deck {
			index = i
			i += 1
		}
	}
	//reset the collection cards
	var i = 0
	with obj_mini_card {
		if !in_deck {
			index = i
			i += 1
		}
	}
	clicked = false	
}

if mouse_wheel_up() {
	scroll_offset -= 5
}
if mouse_wheel_down() {
	scroll_offset += 5	
}