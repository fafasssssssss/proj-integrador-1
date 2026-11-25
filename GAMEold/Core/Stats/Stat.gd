extends Node
class_name Stat

const BASE_VALUE:float = 0#reference to very first starting value
var base_value:float #changes with levels/other sources and is processed before buffs are added
var value:float #total value after mods are applied

var modifiers:Array[Modifier]

func add_mod(new_mod:Modifier) -> void:
	modifiers.append(new_mod)
	new_mod.value_changed.connect(apply_mods)
	new_mod.force_remove.connect(remove_mod)

func remove_mod(mod:Modifier) -> void:
	if modifiers.has(mod): modifiers.erase(mod)

func apply_mods() -> void:
	var flats:Array[float]
	var flats_result:float = 0
	var mults:Array[float]
	var mults_result:float = 1
	var base_mults:Array[float]
	var base_mults_result:float = 0
	for mod in modifiers:
		match mod.type:
			0:#FLAT
				flats.append(mod.value)
			1:#PERCENT
				mults.append(mod.value)
			2:#BASE_PERCENT
				base_mults.append(mod.value)
	if base_mults.size() > 0:
		for v in base_mults:
			base_mults_result += v * base_value
		value += base_mults_result
	if flats.size() > 0:
		for v in flats:
			flats_result += v
		value += flats_result
	if mults.size() > 0:
		for v in mults:
			mults_result += v
		value *= mults_result 
