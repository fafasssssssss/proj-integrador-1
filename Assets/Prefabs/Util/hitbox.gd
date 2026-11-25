extends Area3D

@export var collider: CollisionShape3D
@onready var timer: Timer = $timer

@export var damage:float = 1

func temp_disable() -> void:
	collider.call_deferred("set", "disabled", true)
	timer.start()


func _on_timer_timeout() -> void:
	collider.call_deferred("set", "disabled", false)
