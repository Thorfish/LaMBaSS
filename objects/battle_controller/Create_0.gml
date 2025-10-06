p1 = instance_create_depth(0,0,0,battle_player);
p2 = instance_create_depth(0,0,0,battle_player);

player_cards = [];
enemy_cards = [];

obj_enemy_cards = [];
for (i=0; i<3; i++) {
	array_push(obj_enemy_cards, instance_create_depth(-100, 100, i, obj_enemy_card))
}

function run_turn() {
	first_effects = (random(2) > 1)
	//how many cards are being played
	var num_player_cards = 0
	with obj_card {
		if discarded {
			num_player_cards += 1	
		}
	}
	
	if first_effects {
		for (i=0; i<3; i++) {
			enemy_cards[i].play_effect(p2, p1);
		}
		
		for (i=0; i<num_player_cards; i++) {
			player_cards[i].play_effect(p1, p2);
		}
		
		for (i=0; i<3; i++) {
			enemy_cards[i].block_phase(p2, p1);
		}
		
		for (i=0; i<num_player_cards; i++) {
			player_cards[i].block_phase(p1, p2);
		}
		
		for (i=0; i<3; i++) {
			enemy_cards[i].damage_phase(p2, p1);
		}
		
		
		for (i=0; i<num_player_cards; i++) {
			player_cards[i].damage_phase(p1, p2);
		}
	} else {
		for (i=0; i<num_player_cards; i++) {
			player_cards[i].play_effect(p1, p2);
		}
		
		for (i=0; i<3; i++) {
			enemy_cards[i].play_effect(p2, p1);
		}
		
		for (i=0; i<num_player_cards; i++) {
			player_cards[i].block_phase(p1, p2);
		}
		
		for (i=0; i<3; i++) {
			enemy_cards[i].block_phase(p2, p1);
		}
		
		for (i=0; i<num_player_cards; i++) {
			player_cards[i].damage_phase(p1, p2);
		}
		
		for (i=0; i<3; i++) {
			enemy_cards[i].damage_phase(p2, p1);
		}
	}
	
	enemy_cards = [];
	player_cards = [];
	
	show_debug_message(p1.health);
	show_debug_message(p2.health);
	
	p1.block = 0;
	p2.block = 0;
	player_card_total = 0;
	//destroy all the played cards
	with obj_card {
		if discarded {
			instance_destroy(self)	
		}
	}
	
	with obj_enemy_card {
		instance_destroy(self)
	}
	
	obj_enemy_cards = [];
	for (i=0; i<3; i++) {
		array_push(obj_enemy_cards, instance_create_depth(-100, 100, i, obj_enemy_card));	
	}
	// draw_card 5 times once every 10 frames
	for (var i=1; i<=3; i+=1) {
		hand_controller.alarm[i] = 10*i
	}
}