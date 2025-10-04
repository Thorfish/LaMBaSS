
randomise()

types = tag_get_asset_ids("effect_type", asset_object)
my_type = instance_create_depth(0,0,0,types[random_range(0, array_length(types))])

powers = tag_get_asset_ids("effect_power", asset_object)
my_power = instance_create_depth(0,0,0,powers[random_range(0, array_length(powers))])

adds = tag_get_asset_ids("effect_add", asset_object)
my_add = instance_create_depth(0,0,0,adds[random_range(0, array_length(adds))])

show_debug_message(object_get_name(my_type.object_index))
show_debug_message(object_get_name(my_power.object_index))
show_debug_message(object_get_name(my_add.object_index))

damage = my_type.damage;
block = my_type.block;
power_mod = 1 + my_power.multiplier;

my_power.modify_effect(self)

show_debug_message(damage);
show_debug_message(block);
show_debug_message(power_mod);

function play_effect(user, enemy) {
	my_add.play_effect(self, user, enemy);
	my_power.play_effect(self, user, enemy);
}

function block_phase(user, enemy) {
	user.gain_block(block * power_mod);
}

function damage_phase(user, enemy) {
	enemy.take_damage(damage * power_mod);
}

show_debug_message(card_cost);

show_debug_message(my_type.description);

description = "";
show_debug_message(description);
description += string(my_type.description, damage*power_mod, block*power_mod);
description += "\n";

description += string(my_power.description, my_power.description_val*power_mod);
description += "\n";

description += string(my_add.description, my_add.description_val*power_mod);

function play(user, enemy) {
	
}