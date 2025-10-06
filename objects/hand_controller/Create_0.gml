/// @description Insert description here
// You can write your code in this editor
number_of_cards = 0
card_to_load = noone

function draw_card() {
	if instance_exists(obj_deck_card) {
		var card_to_draw = noone
		with obj_deck_card {
			if index == 0 {
				card_to_draw = self
			} else {
				index -= 1
			}
		}
		deck_index = card_to_draw.card_id
		i = instance_number(obj_card)
		card_to_load = instance_create_depth(100,room_height-50,i,obj_card, {position: i, depth_:i})
		alarm[0] = 5
		number_of_cards += 1
		instance_destroy(card_to_draw)
	} else {
		instance_create_depth(100,room_height-50,i,obj_card, {position: i, depth_:i})
	}
}

if !deckbuilder {
	load_deck()

	// draw_card 5 times once every 10 frames
	for (var i=1; i<=5; i+=1) {
		alarm[i] = 10*i
	}
}
draw_set_font(m5x7)