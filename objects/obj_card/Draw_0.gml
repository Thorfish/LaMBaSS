/// @description Insert description here
// You can write your code in this editor
draw_self()
var position_offset = -100

var x_ = x + lengthdir_x(position_offset, image_angle-90)
var y_ = y + lengthdir_y(position_offset, image_angle-90)

draw_set_halign(fa_center)
draw_text_transformed(x_,y_,description, 1,1,image_angle)
draw_set_halign(fa_left)
