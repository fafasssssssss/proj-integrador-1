extends SkillLogic

@onready var dash_speed:float = base.stats["dash_speed"]

signal dash_started
signal dash_ended

func _on_use():
	player.stats.dash_speed = dash_speed
	super._on_use()
	dash_started.emit("dash", base.cooldown + base.duration)

func _logic():
	player.set_state("DASHING")
	
func _on_end():
	super._on_end()
	player.set_state("IDLE")
	dash_ended.emit()
