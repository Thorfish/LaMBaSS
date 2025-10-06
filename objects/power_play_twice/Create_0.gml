// Inherit the parent event
event_inherited();

function play_effect(card, user, enemy) {
	if played_once == 0 {
		played_once = 1
		card.play_effect(user, enemy)
		played_once = 0;
	}
}

function block_phase(card, user, enemy) {
	if played_once == 0 {
		played_once = 1
		card.block_phase(user, enemy)
		played_once = 0;
	}
}

function damage_phase(card, user, enemy) {
	if played_once == 0 {
		played_once = 1
		card.damage_phase(user, enemy)
		played_once = 0;
	}
}