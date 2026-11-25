extends Node
class_name Stats

var max_hp:float = 30
var regen:float = 1
var mov_speed:float = 5
var damage:float = 15
var armor:float = 0
var atk_speed:float = 1
var crit_rate:float = 1
var crit_dmg:float = 2

var hp:float = max_hp:
	set(value):
		value_changed.emit("hp", value)
var dash_speed:float = 1

signal value_changed(new_value)
