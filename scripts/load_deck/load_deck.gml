// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//this will load your saved deck as a collection of obj_deck_card
function load_deck(){
	randomise()
	var ids = []
	var i = 0
	repeat 20 {
		array_push(ids,i)
		i+=1
	}
	// put the array in a random order
	ids = array_shuffle(ids)
	
	for (var i=0; i <20; i+=1) {
		instance_create_depth(-100,-100,0,obj_deck_card, {card_id:ids[i], index:i})	
	}
	
	ini_open("deck")
}

