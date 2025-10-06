/// @description Insert description here
// You can write your code in this editor

// Load card variables
var names = variable_instance_get_names(card_to_load);
for (var n = 0; n < array_length(names); n++) {
    var vname = names[n];
        
    // Skip position variable - it should not be overwritten
    if (vname != "position") {
        // Try read numeric value from ini file for this card variable
        var val = ini_read_real("card_" + string(deck_index), vname, -99);
        if (val != -99) {
            // Check if this is a special variable that needs instance creation
            if (vname == "effect" || vname == "my_type" || vname == "my_power" || vname == "my_add") {
                variable_instance_set(card_to_load, vname, instance_create_depth(0, 0, 0, val))
            } else {
                variable_instance_set(card_to_load, vname, val)
            }
        } else {
            // Try read string value from ini file for this card variable
            var str_val = ini_read_string("card_" + string(deck_index), vname, "");
            if (str_val != "") {
                var decoded_str = base64_decode(str_val)
                variable_instance_set(card_to_load, vname, decoded_str)
            }
        }
    }
}
    
// Load effect variables
if (card_to_load.effect != noone) {
    var effect_names = variable_instance_get_names(card_to_load.effect);
    for (var k = 0; k < array_length(effect_names); k++) {
        var vname = effect_names[k];
        var val = ini_read_real("effect_" + string(deck_index), vname, -99);
        var str_val = ini_read_string("effect_" + string(deck_index), vname, "");
            
        // Skip special variables that are already created as instances
        if (vname != "my_type" && vname != "my_power" && vname != "my_add") {
            // Force numeric variables to always be numbers
            if ((vname == "card_cost" || vname == "damage" || vname == "block" || vname == "power_mod") && val != -99) {
                variable_instance_set(card_to_load.effect, vname, val)
            } else {
                // Check if we have a string value (base64 encoded)
                if (str_val != "" && str_val != string(val)) {
                    var decoded_str = base64_decode(str_val)
                    variable_instance_set(card_to_load.effect, vname, decoded_str)
                } else if (val != -99) {
                    variable_instance_set(card_to_load.effect, vname, val)
                }
            }
        } else if (val != -99) {
            // Create the special instance variables
            if (vname == "my_type") {
                card_to_load.effect.my_type = instance_create_depth(0, 0, 0, val)
            } else if (vname == "my_power") {
                card_to_load.effect.my_power = instance_create_depth(0, 0, 0, val)
            } else if (vname == "my_add") {
                card_to_load.effect.my_add = instance_create_depth(0, 0, 0, val)
            }
        }
    }
        
    // Load my_type variables
    if (card_to_load.effect.my_type != noone) {
        var type_names = variable_instance_get_names(card_to_load.effect.my_type);
        for (var m = 0; m < array_length(type_names); m++) {
            var vname = type_names[m];
            var val = ini_read_real("type_" + string(deck_index), vname, -99);
            var str_val = ini_read_string("type_" + string(deck_index), vname, "");
                
            // Force numeric variables to always be numbers
            if ((vname == "damage" || vname == "block" || vname == "description_val" || vname == "extra_add") && val != -99) {
                variable_instance_set(card_to_load.effect.my_type, vname, val)
            } else {
                // Check if we have a string value (base64 encoded)
                if (str_val != "" && str_val != string(val)) {
                    var decoded_str = base64_decode(str_val)
                    variable_instance_set(card_to_load.effect.my_type, vname, decoded_str)
                } else if (val != -99) {
                    variable_instance_set(card_to_load.effect.my_type, vname, val)
                }
            }
        }
    }
        
    // Load my_power variables
    if (card_to_load.effect.my_power != noone) {
        var power_names = variable_instance_get_names(card_to_load.effect.my_power);
        for (var p = 0; p < array_length(power_names); p++) {
            var vname = power_names[p];
            var val = ini_read_real("power_" + string(deck_index), vname, -99);
            var str_val = ini_read_string("power_" + string(deck_index), vname, "");
                
            // Force numeric variables to always be numbers
            if ((vname == "multiplier" || vname == "self_damage" || vname == "description_val" || vname == "played_once") && val != -99) {
                variable_instance_set(card_to_load.effect.my_power, vname, val)
            } else {
                // Check if we have a string value (base64 encoded)
                if (str_val != "" && str_val != string(val)) {
                    var decoded_str = base64_decode(str_val)
                    variable_instance_set(card_to_load.effect.my_power, vname, decoded_str)
                } else if (val != -99) {
                    variable_instance_set(card_to_load.effect.my_power, vname, val)
                }
            }
        }
    }
        
    // Load my_add variables
    if (card_to_load.effect.my_add != noone) {
        var add_names = variable_instance_get_names(card_to_load.effect.my_add);
        for (var q = 0; q < array_length(add_names); q++) {
            var vname = add_names[q];
            var val = ini_read_real("add_" + string(deck_index), vname, -99);
            var str_val = ini_read_string("add_" + string(deck_index), vname, "");
                
            // Force numeric variables to always be numbers
            if ((vname == "heal_by" || vname == "pierce_damage" || vname == "description_val") && val != -99) {
                variable_instance_set(card_to_load.effect.my_add, vname, val)
            } else {
                // Check if we have a string value (base64 encoded)
                if (str_val != "" && str_val != string(val)) {
                    var decoded_str = base64_decode(str_val)
                    variable_instance_set(card_to_load.effect.my_add, vname, decoded_str)
                } else if (val != -99) {
                    variable_instance_set(card_to_load.effect.my_add, vname, val)
                }
            }
        }
    }
}
    
// Set description from effect after loading
if (card_to_load.effect != noone && variable_instance_exists(card_to_load.effect, "description")) {
    card_to_load.description = card_to_load.effect.description
}
    
// Set image index based on type
if (card_to_load.effect.my_type != noone) {
    if (card_to_load.effect.my_type.object_index == type_damage) {
        card_to_load.image_index = 0
    } else if (card_to_load.effect.my_type.object_index == type_defence) {
        card_to_load.image_index = 1
    }
}
