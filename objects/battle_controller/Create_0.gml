p1 = instance_create_depth(0,0,0,battle_player);
p2 = instance_create_depth(0,0,0,battle_player);

player_cards = [];
enemy_cards = [];

status_effects = []
function add_status(status, target) {
	status.target = target;
	status.infliction();
	array_push(status_effects, status);
}

obj_enemy_cards = [];
for (i=0; i<3; i++) {
	array_push(obj_enemy_cards, instance_create_depth(-100, 100, i, obj_enemy_card))
}

function run_turn() {
	audio_play_sound(clash_sound,0,0,1,0,random_range(0.9,1.1))
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
	
	// Activate status effects
	_i = 0
	while _i < array_length(status_effects) {
		status_effects[_i].during()
		status_effects[_i].duration -= 1
		if status_effects[_i].duration < 0 {
			status_effects[_i].recovery()
			instance_destroy(status_effects[_i])
			array_delete(status_effects, _i, 1)
			
		} else {
			_i++
		}
	}
	
	enemy_cards = [];
	player_cards = [];
	
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