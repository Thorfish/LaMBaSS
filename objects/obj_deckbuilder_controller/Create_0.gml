/// @description Deck Builder Controller - Handles deck creation, saving, and loading
// This controller manages the deck building system, including saving card data to files and loading decks

// Initialize deck counter
cards_in_deck = 0

// LOAD DECK FUNCTION
// Loads a previously saved deck from the INI file
function load_deck_() {
	// Read the number of cards in the saved deck
	var num = ini_read_real("num", "num", 0);
	show_debug_message("num: " + string(num))
	
	// Create mini card instances for each card in the saved deck
    for (var i = 0; i <= num; i++) {
        var card_instance = instance_create_depth(100, room_height/2, 0, obj_mini_card, {in_deck:true, loaded:true});
	}
	
	// Set alarm to trigger after cards are loaded
	alarm[0] = 10
}


// GENERATE DECK FUNCTION
// Creates a new deck by generating random cards and saving their data to INI file
function generate_deck() {
	// Create temporary controller instances for deck generation
	var temp1 = instance_create_depth(-100, -100, 0, battle_controller)
	var temp2 = instance_create_depth(-100,-100,0, hand_controller, {deckbuilder:true})
	
	// Generate 20 random cards for the deck
	repeat 20 {
		instance_create_depth(-100,-100,0,obj_card)	
	}
	
	// Card counter for saving
	var j = 0
	with obj_card {
		show_debug_message(j)
		
		// Get all variable names from the card instance
		var names = variable_instance_get_names(self)
		
		// SAVE CARD VARIABLES
		// Save all numeric, string, and reference variables from the card
		for (var i=0; i<array_length(names); i+=1) {
			var vname = names[i]
			if typeof(variable_instance_get(self, vname)) == "ref" {
				// Save object references as their object_index
				ini_write_real("card_"+string(j), vname, variable_instance_get(self, vname).object_index) 
			} else if is_numeric(variable_instance_get(self, vname)) {
				// Save numeric values directly
				ini_write_real("card_"+string(j), vname, variable_instance_get(self, vname)) 
			} else if is_string(variable_instance_get(self, vname)) {
				// Encode strings in base64 to handle special characters
				var str_val = base64_encode(variable_instance_get(self, vname))
				ini_write_string("card_"+string(j), vname, str_val) 
			}
		}
		
		// SAVE EFFECT VARIABLES
		// Save all variables from the card's effect object
		names = variable_instance_get_names(effect)
		for (var i=0; i<array_length(names); i+=1) {
			var vname = names[i]
			if typeof(variable_instance_get(effect, vname)) == "ref" {
				// Save object references as their object_index
				ini_write_real("effect_"+string(j), vname, variable_instance_get(effect, vname).object_index) 
			} else if is_numeric(variable_instance_get(effect, vname)) {
				// Save numeric values directly
				ini_write_real("effect_"+string(j), vname, variable_instance_get(effect, vname)) 
			} else if is_string(variable_instance_get(effect, vname)) {
				// Encode strings in base64 to handle special characters
				var str_val = base64_encode(variable_instance_get(effect, vname))
				ini_write_string("effect_"+string(j), vname, str_val) 
			}
		}
		
		// SAVE TYPE VARIABLES
		// Save all variables from the effect's type object
		names = variable_instance_get_names(effect.my_type)
		for (var i=0; i<array_length(names); i+=1) {
			var vname = names[i]
			if typeof(variable_instance_get(effect.my_type, vname)) == "ref" {
				// Save object references as their object_index
				ini_write_real("type_"+string(j), vname, variable_instance_get(effect.my_type, vname).object_index) 
			} else if is_numeric(variable_instance_get(effect.my_type, vname)) {
				// Save numeric values directly
				ini_write_real("type_"+string(j), vname, variable_instance_get(effect.my_type, vname)) 
			} else if is_string(variable_instance_get(effect.my_type, vname)) {
				// Encode strings in base64 to handle special characters
				var str_val = base64_encode(variable_instance_get(effect.my_type, vname))
				ini_write_string("type_"+string(j), vname, str_val) 
			}
		}
		
		// SAVE POWER VARIABLES
		// Save all variables from the effect's power object
		names = variable_instance_get_names(effect.my_power)
		for (var i=0; i<array_length(names); i+=1) {
			var vname = names[i]
			if typeof(variable_instance_get(effect.my_power, vname)) == "ref" {
				// Save object references as their object_index
				ini_write_real("power_"+string(j), vname, variable_instance_get(effect.my_power, vname).object_index) 
			} else if is_numeric(variable_instance_get(effect.my_power, vname)) {
				// Save numeric values directly
				ini_write_real("power_"+string(j), vname, variable_instance_get(effect.my_power, vname)) 
			} else if is_string(variable_instance_get(effect.my_power, vname)) {
				// Encode strings in base64 to handle special characters
				var str_val = base64_encode(variable_instance_get(effect.my_power, vname))
				ini_write_string("power_"+string(j), vname, str_val) 
			}
		}
		
		// SAVE ADD VARIABLES
		// Save all variables from the effect's add object
		names = variable_instance_get_names(effect.my_add)
		for (var i=0; i<array_length(names); i+=1) {
			var vname = names[i]
			if typeof(variable_instance_get(effect.my_add, vname)) == "ref" {
				// Save object references as their object_index
				ini_write_real("add_"+string(j), vname, variable_instance_get(effect.my_add, vname).object_index) 
			} else if is_numeric(variable_instance_get(effect.my_add, vname)) {
				// Save numeric values directly
				ini_write_real("add_"+string(j), vname, variable_instance_get(effect.my_add, vname)) 
			} else if is_string(variable_instance_get(effect.my_add, vname)) {
				// Encode strings in base64 to handle special characters
				var str_val = base64_encode(variable_instance_get(effect.my_add, vname))
				ini_write_string("add_"+string(j), vname, str_val) 
			}
		}
		
		// Increment card counter and destroy the temporary card instance
		j+=1
		instance_destroy(self)
	}
	// CLEANUP TEMPORARY OBJECTS
	// Destroy all temporary objects created during deck generation
	with obj_deck_card {
		instance_destroy(self)
	}
	with obj_enemy_card {
		instance_destroy(self)	
	}
	with stats_display {
		instance_destroy(self)	
	}
	// Destroy temporary controller instances
	instance_destroy(temp1)
	instance_destroy(temp2)
	
	// Save the total number of cards generated and load the deck
	ini_write_real("num", "num", j-1)
	load_deck_()
}	

// INITIALIZATION LOGIC
// Check if deck file exists and either generate new deck or load existing one
if !file_exists("deck") {
	// No deck file exists, create a new one
	ini_open("deck")
	show_debug_message("generate deck")
	generate_deck()	
} else {
	// Deck file exists, load the existing deck
	ini_open("deck")	
	load_deck_()
}


