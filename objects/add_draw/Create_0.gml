// Inherit the parent event
event_inherited();

cards_drawn *= basic_mult()
description_val = cards_drawn

function play_effect(card, user, enemy) {
	if user.is_player {
		for (var i=1; i<=round(cards_drawn * card.power_mod); i+=1) {
			hand_controller.alarm[6] = 50
			hand_controller.cards_to_draw++
		}
	}
}