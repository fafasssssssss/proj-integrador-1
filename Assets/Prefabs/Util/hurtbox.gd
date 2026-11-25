extends Area3D

@export_enum("COOLDOWN", "HIT_ONCE", "DISABLE_HITBOX") var HurtBoxType = 0

@export var collider: CollisionShape3D
@onready var timer: Timer = $timer

signal hurt(damage)

func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("Attack"):
		match HurtBoxType:
			0:#COOLDOWN
				collider.call_deferred("set", "disabled", true)
				timer.start()
			1:#HIT_ONCE
				pass
			2:#DISABLE_HITBOX
				if area.has_method("temp_disable"):
					area.temp_disable()
		var damage = area.damage
		hurt.emit(damage)


func _on_timer_timeout() -> void:
	collider.call_deferred("set", "disabled", false)
