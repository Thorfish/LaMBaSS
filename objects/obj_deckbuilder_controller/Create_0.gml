/// @description Insert description here
// You can write your code in this editor
cards_in_deck = 0

function load_deck_() {
	var num = ini_read_real("num", "num", 0);
	show_debug_message("num: " + string(num))
    for (var i = 0; i <= num; i++) {
        var card_instance = instance_create_depth(100, room_height/2, 0, obj_mini_card, {in_deck:true, loaded:true});
	}
	alarm[0] = 10
}


function generate_deck() {
	var temp1 = instance_create_depth(-100, -100, 0, battle_controller)
	var temp2 = instance_create_depth(-100,-100,0, hand_controller, {deckbuilder:true})
	repeat 20 {
		instance_create_depth(-100,-100,0,obj_card)	
	}
	
	var j = 0
	with obj_card {
		show_debug_message(j)
		var names = variable_instance_get_names(self)
		// save the cards numeric and string variables
		for (var i=0; i<array_length(names); i+=1) {
			var vname = names[i]
			if typeof(variable_instance_get(self, vname)) == "ref" {
				ini_write_real("card_"+string(j), vname, variable_instance_get(self, vname).object_index) 
			} else if is_numeric(variable_instance_get(self, vname)) {
				ini_write_real("card_"+string(j), vname, variable_instance_get(self, vname)) 
			} else if is_string(variable_instance_get(self, vname)) {
				var str_val = base64_encode(variable_instance_get(self, vname))
				ini_write_string("card_"+string(j), vname, str_val) 
			}
		}
		
		//save the effects numeric and string variables
		names = variable_instance_get_names(effect)
		for (var i=0; i<array_length(names); i+=1) {
			var vname = names[i]
			if typeof(variable_instance_get(effect, vname)) == "ref" {
				ini_write_real("effect_"+string(j), vname, variable_instance_get(effect, vname).object_index) 
			} else if is_numeric(variable_instance_get(effect, vname)) {
				ini_write_real("effect_"+string(j), vname, variable_instance_get(effect, vname)) 
			} else if is_string(variable_instance_get(effect, vname)) {
				var str_val = base64_encode(variable_instance_get(effect, vname))
				ini_write_string("effect_"+string(j), vname, str_val) 
			}
		}
		
		//save the types numeric and string values
		names = variable_instance_get_names(effect.my_type)
		for (var i=0; i<array_length(names); i+=1) {
			var vname = names[i]
			if typeof(variable_instance_get(effect.my_type, vname)) == "ref" {
				ini_write_real("type_"+string(j), vname, variable_instance_get(effect.my_type, vname).object_index) 
			} else if is_numeric(variable_instance_get(effect.my_type, vname)) {
				ini_write_real("type_"+string(j), vname, variable_instance_get(effect.my_type, vname)) 
			} else if is_string(variable_instance_get(effect.my_type, vname)) {
				var str_val = base64_encode(variable_instance_get(effect.my_type, vname))
				ini_write_string("type_"+string(j), vname, str_val) 
			}
		}
		
		//save the power numeric and string values
		names = variable_instance_get_names(effect.my_power)
		for (var i=0; i<array_length(names); i+=1) {
			var vname = names[i]
			if typeof(variable_instance_get(effect.my_power, vname)) == "ref" {
				ini_write_real("power_"+string(j), vname, variable_instance_get(effect.my_power, vname).object_index) 
			} else if is_numeric(variable_instance_get(effect.my_power, vname)) {
				ini_write_real("power_"+string(j), vname, variable_instance_get(effect.my_power, vname)) 
			} else if is_string(variable_instance_get(effect.my_power, vname)) {
				var str_val = base64_encode(variable_instance_get(effect.my_power, vname))
				ini_write_string("power_"+string(j), vname, str_val) 
			}
		}
		
		//save the add numeric and string values
		names = variable_instance_get_names(effect.my_add)
		for (var i=0; i<array_length(names); i+=1) {
			var vname = names[i]
			if typeof(variable_instance_get(effect.my_add, vname)) == "ref" {
				ini_write_real("add_"+string(j), vname, variable_instance_get(effect.my_add, vname).object_index) 
			} else if is_numeric(variable_instance_get(effect.my_add, vname)) {
				ini_write_real("add_"+string(j), vname, variable_instance_get(effect.my_add, vname)) 
			} else if is_string(variable_instance_get(effect.my_add, vname)) {
				var str_val = base64_encode(variable_instance_get(effect.my_add, vname))
				ini_write_string("add_"+string(j), vname, str_val) 
			}
		}
		
		j+=1
		instance_destroy(self)
	}
	with obj_deck_card {
		instance_destroy(self)
	}
	with obj_enemy_card {
		instance_destroy(self)	
	}
	with stats_display {
		instance_destroy(self)	
	}
	instance_destroy(temp1)
	instance_destroy(temp2)
	ini_write_real("num", "num", j-1)
	load_deck_()
}	

if !file_exists("deck") {
	ini_open("deck")
	show_debug_message("generate deck")
	generate_deck()	
} else {
	ini_open("deck")	
	load_deck_()
}


