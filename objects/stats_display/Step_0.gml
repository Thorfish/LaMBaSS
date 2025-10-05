/// @description Insert description here
// You can write your code in this editor
var damage_ = 0
var block_ = 0
var effects_ = []
with obj_card {
	if discarded {
		damage_ +=  round(effect.damage*effect.power_mod)
		block_ +=  round(effect.block*effect.power_mod)
		array_push(effects_, string(effect.my_add.description,   round(effect.my_add.description_val*effect.power_mod)))
	}
}

damage = damage_
block = block_
effects = effects_