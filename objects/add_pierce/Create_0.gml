event_inherited();

pierce_damage *= basic_mult()
description_val = pierce_damage

function play_effect(card, user, enemy) {
	enemy.health -= round(pierce_damage * card.power_mod);
}