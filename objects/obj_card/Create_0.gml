/// @description Insert description here
// You can write your code in this editor
hovered = false
clicked = false
discarded = false

// if the card is glowing yellow or not
active = false
depth = depth_

audio = false

// Creating card here, move elsewhere later
effect = instance_create_depth(0,0,0,card_effect);
description = effect.description;

if effect.my_type.object_index == type_damage {
	image_index = 0	
} else if effect.my_type.object_index == type_defence {
	image_index = 1	
}
