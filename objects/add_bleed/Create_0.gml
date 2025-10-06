// Inherit the parent event
event_inherited();

damage *= basic_mult()
description_val = damage

function play_effect(card, user, enemy) {
	bleedstatus = instance_create_depth(0,0,0, status_bleed)
	bleedstatus.damage = round(damage * card.power_mod)
	bleedstatus.duration = 4
	battle_controller.add_status(bleedstatus, enemy)
}