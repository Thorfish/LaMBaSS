
randomise()

types = tag_get_asset_ids("effect_type", asset_object)
my_type = instance_create_depth(0,0,0,types[random_range(0, array_length(types))])

powers = tag_get_asset_ids("effect_power", asset_object)
my_power = instance_create_depth(0,0,0,powers[random_range(0, array_length(powers))])

//adds = tag_get_asset_ids("effect_add", asset_object)
//my_add = instance_create_depth(0,0,0,adds[random_range(0, array_length(adds))])

my_add = instance_create_depth(0,0,0,add_nothing)

show_debug_message(object_get_name(my_type.object_index))
show_debug_message(object_get_name(my_power.object_index))
show_debug_message(object_get_name(my_add.object_index))

damage = my_type.damage;
block = my_type.block;
power_mod = 1 + my_power.multiplier;

my_power.modify_effect(self)

function play_effect(user, enemy) {
	my_add.play_effect(self, user, enemy);
	my_power.play_effect(self, user, enemy);
	my_type.play_effect(self, user, enemy);
}

function block_phase(user, enemy) {
	user.block += block * power_mod
	my_power.block_phase(self, user, enemy)
}

function damage_phase(user, enemy) {
	fdamage = damage * power_mod
	if fdamage > enemy.block {
		fdamage -= enemy.block
		enemy.block = 0
		enemy.health -= fdamage
	} else {
		enemy.block -= fdamage
	}
	my_power.damage_phase(self, user, enemy)
}

description = "";
description += string(my_type.description, round(my_type.description_val*power_mod));
description += "\n";

description += string(my_power.description,  round(my_power.description_val*power_mod));
description += "\n";

description += string(my_add.description,   round(my_add.description_val*power_mod));
