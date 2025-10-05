/// @description Insert description here
// You can write your code in this editor
draw_self()
var position_offset = -100

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
