extends CharacterBody3D

@onready var player:PlayerMaster = get_tree().get_first_node_in_group("Player")
@export var hp:float = 20


func _physics_process(delta: float) -> void:
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 2
		move_and_slide()


func _on_hurtbox_hurt(damage: float) -> void:
	hp -= damage
	if hp <= 0: queue_free()
