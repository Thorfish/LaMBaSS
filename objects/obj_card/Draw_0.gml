/// @description Insert description here
// You can write your code in this editor
if active {
	draw_sprite_ext(sprite_index, image_index, x,y, image_xscale, image_yscale, image_angle, c_yellow, image_alpha)
} else {
	draw_self()
}
draw_sprite_ext(spr_card_outer, card_type, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);
var position_offset = -50

var x_ = x + lengthdir_x(position_offset, image_angle-90)
var y_ = y + lengthdir_y(position_offset, image_angle-90)

draw_set_halign(fa_center)
var max_width = 120
var current_text_width = string_width(description);
var text_scale = 1; // Default scale

if (current_text_width > max_width) {
    text_scale = max_width / current_text_width;
}
draw_text_transformed(x_,y_,description, text_scale,text_scale,image_angle)
draw_set_halign(fa_left)
