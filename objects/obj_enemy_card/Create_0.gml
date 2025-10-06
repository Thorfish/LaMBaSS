/// @description Insert description here
// You can write your code in this editor

// Creating card here, move elsewhere later
effect = instance_create_depth(0,0,0,card_effect);
description = effect.description;

position = depth

if effect.my_type.object_index == type_damage {
	image_index = 0	
} else if effect.my_type.object_index == type_defence {
	image_index = 1	
} else if effect.my_type.object_index == type_extra {
	image_index = 2	
}

array_push(battle_controller.enemy_cards, effect)