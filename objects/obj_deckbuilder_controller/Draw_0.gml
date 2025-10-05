/// @description Insert description here
// You can write your code in this editor
var i=0
with obj_mini_card {
	if in_deck {
		i+=1
	}	
}
cards_in_deck = i
draw_set_font(m5x7)
draw_text(400,22, string(cards_in_deck)+"/20")
