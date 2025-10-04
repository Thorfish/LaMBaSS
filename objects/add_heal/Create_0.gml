// Inherit the parent event
event_inherited();

heal_by *= basic_mult()
description_val = heal_by

function play_effect(card, user, enemy) {
	user.health += heal_by * card.power_mod;
}