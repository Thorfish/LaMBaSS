/// @description Insert description here
// You can write your code in this editor
event_inherited()
clicked = false
in_deck = true
scroll_offset = 0
image_xscale = 0.5
image_yscale = 0.5
index = 0

var i = 0
if in_deck {
	with obj_mini_card {
		if in_deck {
			index = i
			i += 1
		}
	}
} else {
	with obj_mini_card {
		if !in_deck {
			index = i
			i += 1
		}
	}
}
