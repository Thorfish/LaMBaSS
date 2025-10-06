// Inherit the parent event
event_inherited();

pierce_damage *= basic_mult()
description_val = pierce_damage

function play_effect(card, user, enemy) {
	crabstatus = instance_create_depth(0,0,0, status_crab)
	crabstatus.damage = round(pierce_damage * card.power_mod)
	crabstatus.duration = 1
	battle_controller.add_status(crabstatus, enemy)
}