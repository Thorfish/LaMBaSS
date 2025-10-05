/// @description Insert description here
// You can write your code in this editor
var i = 0
with obj_mini_card {
    // Create effect structure first if it doesn't exist
    if (!variable_instance_exists(self, "effect") || self.effect == noone) {
        self.effect = instance_create_depth(0, 0, 0, card_effect)
    }
    
    // Load card variables
    var names = variable_instance_get_names(self);
    for (var n = 0; n < array_length(names); n++) {
        var vname = names[n];
            
        // Try read numeric value from ini file for this card variable
        var val = ini_read_real("card_" + string(i), vname, -99);
        if (val != -99) {
                
            // Check if this is a special variable that needs instance creation
            if (vname == "effect" || vname == "my_type" || vname == "my_power" || vname == "my_add") {
                variable_instance_set(self, vname, instance_create_depth(0, 0, 0, val))
            } else {
                variable_instance_set(self, vname, val)
            }
        } else {
            // Try read string value from ini file for this card variable
            var str_val = ini_read_string("card_" + string(i), vname, "");
            if (str_val != "") {
                var decoded_str = base64_decode(str_val)
                variable_instance_set(self, vname, decoded_str)
            }
        }
    }
        
    // Similarly for effect variables
    if (self.effect != noone) {
        var effect_names = variable_instance_get_names(self.effect);
        for (var k = 0; k < array_length(effect_names); k++) {
            var vname = effect_names[k];
            var val = ini_read_real("effect_" + string(i), vname, -99);
            var str_val = ini_read_string("effect_" + string(i), vname, "");
            
            // Skip special variables that are already created as instances
            if (vname != "my_type" && vname != "my_power" && vname != "my_add") {
                // Check if we have a string value (base64 encoded)
                if (str_val != "" && str_val != string(val)) {
                    var decoded_str = base64_decode(str_val)
                    variable_instance_set(self.effect, vname, decoded_str)
                } else if (val != -99) {
                    variable_instance_set(self.effect, vname, val)
                }
            } else if (val != -99) {
				show_debug_message("Creating instance: " + vname + " with object index " + string(val))
				if (vname == "my_type") {
					self.effect.my_type = instance_create_depth(0, 0, 0, val)
					show_debug_message("Created my_type instance: " + string(self.effect.my_type.object_index))
				} else if (vname == "my_power") {
					self.effect.my_power = instance_create_depth(0, 0, 0, val)
					show_debug_message("Created my_power instance: " + string(self.effect.my_power.object_index))
				} else if (vname == "my_add") {
					self.effect.my_add = instance_create_depth(0, 0, 0, val)
					show_debug_message("Created my_add instance: " + string(self.effect.my_add.object_index))
				}
			}
        }
            
        // Repeat loading for effect.my_type, effect.my_power, effect.my_add similarly by getting variable names and reading ini values
        // For example:
        if (self.effect.my_type != noone) {
            var type_names = variable_instance_get_names(self.effect.my_type);
            show_debug_message("Type instance exists, has " + string(array_length(type_names)) + " variables")
            for (var m = 0; m < array_length(type_names); m++) {
                var vname = type_names[m];
                var val = ini_read_real("type_" + string(i), vname, -99);
                var str_val = ini_read_string("type_" + string(i), vname, "");
                
                // Check if we have a string value (base64 encoded)
                if (str_val != "" && str_val != string(val)) {
                    var decoded_str = base64_decode(str_val)
                    variable_instance_set(self.effect.my_type, vname, decoded_str)
                } else if (val != -99) {
                    // Check if this is a special variable that needs instance creation
                    if (vname == "effect" || vname == "my_type" || vname == "my_power" || vname == "my_add") {
                        // Skip these - they're handled in the effect loading section
                    } else {
                        variable_instance_set(self.effect.my_type, vname, val)
                    }
                }
            }
        } else {
            show_debug_message("Type instance is noone!")
        }
            
        // Repeat for my_power
        if (self.effect.my_power != noone) {
            var power_names = variable_instance_get_names(self.effect.my_power);
            show_debug_message("Power instance exists, has " + string(array_length(power_names)) + " variables")
            for (var p = 0; p < array_length(power_names); p++) {
                var vname = power_names[p];
                var val = ini_read_real("power_" + string(i), vname, -99);
                var str_val = ini_read_string("power_" + string(i), vname, "");
                
                // Check if we have a string value (base64 encoded)
                if (str_val != "" && str_val != string(val)) {
                    var decoded_str = base64_decode(str_val)
                    variable_instance_set(self.effect.my_power, vname, decoded_str)
                } else if (val != -99) {
                    // Check if this is a special variable that needs instance creation
                    if (vname == "effect" || vname == "my_type" || vname == "my_power" || vname == "my_add") {
                        // Skip these - they're handled in the effect loading section
                    } else {
                        variable_instance_set(self.effect.my_power, vname, val)
                    }
                }
            }
        } else {
            show_debug_message("Power instance is noone!")
        }
            
        // Repeat for my_add
        if (self.effect.my_add != noone) {
            var add_names = variable_instance_get_names(self.effect.my_add);
            show_debug_message("Add instance exists, has " + string(array_length(add_names)) + " variables")
            for (var q = 0; q < array_length(add_names); q++) {
                var vname = add_names[q];
                var val = ini_read_real("add_" + string(i), vname, -99);
                var str_val = ini_read_string("add_" + string(i), vname, "");
                
                // Check if we have a string value (base64 encoded)
                if (str_val != "" && str_val != string(val)) {
                    var decoded_str = base64_decode(str_val)
                    variable_instance_set(self.effect.my_add, vname, decoded_str)
                } else if (val != -99) {
                    // Check if this is a special variable that needs instance creation
                    if (vname == "effect" || vname == "my_type" || vname == "my_power" || vname == "my_add") {
                        // Skip these - they're handled in the effect loading section
                    } else {
                        variable_instance_set(self.effect.my_add, vname, val)
                    }
                }
            }
        } else {
            show_debug_message("Add instance is noone!")
        }
    }
    
    // Set description from effect after loading
    if (self.effect != noone && variable_instance_exists(self.effect, "description")) {
        self.description = self.effect.description
    }
    
    // Debug: Show final instance types
    if (self.effect != noone) {
        show_debug_message("Final types - my_type: " + string(self.effect.my_type.object_index) + 
                          ", my_power: " + string(self.effect.my_power.object_index) + 
                          ", my_add: " + string(self.effect.my_add.object_index))
    }
    if effect.my_type.object_index == type_damage {
		image_index = 0	
	} else if effect.my_type.object_index == type_defence {
		image_index = 1	
	}
	i+=1
}

ini_close()