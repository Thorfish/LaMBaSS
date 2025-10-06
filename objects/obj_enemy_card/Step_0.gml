/// @description Insert description here
// You can write your code in this editor
var num_of_discarded = 0
with obj_enemy_card {
	num_of_discarded += 1
}

x = lerp(x, room_width/2 + sprite_width/2 - (num_of_discarded/2)*card_spread + position*card_spread, 0.1)
y = lerp(y, 200, 0.1)
image_angle = lerp(image_angle, 0, 0.1)