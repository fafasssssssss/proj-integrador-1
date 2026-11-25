extends Node
class_name GayDirector

#Enums
var game_state := Enums.GAME_STATE:
	set(value):
		game_state_changed.emit(value)
#Managers
var EM:EnemyManager

#Signals
signal stage_started
signal game_state_changed

func _ready() -> void:
	EM = EnemyManager.new()

func _on_stage_start() -> void:
	game_state = Enums.GAME_STATE.CALM
	
	stage_started.emit()
	
	
#func testing() -> void:
	var test_stat:Stat = Stat.new()
	var mod1:Modifier = Modifier.new()
	var mod2:Modifier = Modifier.new()
	var mod3:Modifier = Modifier.new()
	
	test_stat.add_mod(mod1)
	test_stat.add_mod(mod2)
	test_stat.add_mod(mod3)
	
	print(test_stat.modifiers)
	
	test_stat.remove_mod(mod2)
	
	print(test_stat.modifiers)
