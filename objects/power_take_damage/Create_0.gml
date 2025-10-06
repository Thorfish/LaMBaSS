// Inherit the parent event
event_inherited();

self_damage *= basic_mult();
description_val = self_damage;

function play_effect(card, user, enemy) {
	user.health -= round(self_damage*card.power_mod);	
}
