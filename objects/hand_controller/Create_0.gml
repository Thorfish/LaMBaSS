/// @description Insert description here
// You can write your code in this editor
number_of_cards = 0

for (var i=0; i<=5; i+=1) {
	instance_create_depth(-100,room_height+100,i,obj_card, {position: i, depth_:i})
	number_of_cards += 1
}