/// @description Insert description here
// You can write your code in this editor
draw_sprite(spr_attack_symbol,  0, 30,30)
draw_sprite(spr_block_symbol,  0, 30,70)
draw_sprite(spr_effect_symbol,  0, 30,110)

draw_text(60,30, damage)
draw_text(60,70, block)
for (var i=0; i<array_length(effects); i+=1) {
	draw_text(60, 110 + 20*i, effects[i])	
}