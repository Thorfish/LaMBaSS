// Inherit the parent event
event_inherited();

self_damage *= basic_mult();

function play_effect(card, user, enemy) {
	user.health -= self_damage;	
}
