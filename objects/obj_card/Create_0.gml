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

card_type = 0;

if effect.my_type.object_index == type_damage {
	card_type = 0	
} else if effect.my_type.object_index == type_defence {
	card_type = 1	
}
