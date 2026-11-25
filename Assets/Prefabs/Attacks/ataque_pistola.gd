extends Area3D

@onready var player:PlayerMaster = get_tree().get_first_node_in_group("Player")

var hp = 1
var speed  = 100
var damage = 5
var knockback = 100
var attack_size:float = 1.0

var target:Vector3 = Vector3.ZERO
var angle:Vector3 = Vector3.ZERO

func _ready() -> void:
	angle = global_position.direction_to(target)
	rotation_degrees.angle_to(target)
	
func _physics_process(delta: float) -> void:
	position += angle * speed * delta

func enemy_hit(charge = 1) -> void:
	hp -= charge
	if hp <= 0: queue_free()

func _on_timer_timeout() -> void:
	queue_free()
