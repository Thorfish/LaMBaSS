// Inherit the parent event
event_inherited();

adds = tag_get_asset_ids("effect_add", asset_object)
extra_add = instance_create_depth(0,0,0,adds[random_range(0, array_length(adds))])

description = extra_add.description
description_val = extra_add.description_val

function play_effect(card, user, enemy) {
	extra_add.play_effect(card, user, enemy)	
}