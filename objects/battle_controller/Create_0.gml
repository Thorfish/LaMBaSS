p1 = instance_create_depth(0,0,0,battle_player);
p2 = instance_create_depth(0,0,0,battle_player);

player_cards = [];
enemy_cards = [];

function run_turn() {
	for (i=0; i<3; i++) {
		array_push(enemy_cards, instance_create_depth(0,0,0,card_effect));	
	}
	
	first_effects = (random(2) > 1)
	
	if first_effects {
		for (i=0; i<3; i++) {
			enemy_cards[i].play_effect(p2, p1);
		}
		
		for (i=0; i<3; i++) {
			player_cards[i].play_effect(p1, p2);
		}
		
		for (i=0; i<3; i++) {
			enemy_cards[i].block_phase(p2, p1);
		}
		
		for (i=0; i<3; i++) {
			player_cards[i].block_phase(p1, p2);
		}
		
		for (i=0; i<3; i++) {
			enemy_cards[i].damage_phase(p2, p1);
		}
		
		
		for (i=0; i<3; i++) {
			player_cards[i].damage_phase(p1, p2);
		}
	} else {
		for (i=0; i<3; i++) {
			player_cards[i].play_effect(p1, p2);
		}
		
		for (i=0; i<3; i++) {
			enemy_cards[i].play_effect(p2, p1);
		}
		
		for (i=0; i<3; i++) {
			player_cards[i].block_phase(p1, p2);
		}
		
		for (i=0; i<3; i++) {
			enemy_cards[i].block_phase(p2, p1);
		}
		
		for (i=0; i<3; i++) {
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
}