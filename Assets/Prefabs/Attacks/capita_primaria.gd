extends Node3D

@onready var player:PlayerMaster = get_tree().get_first_node_in_group("Player")

@export var areaRanged:Area3D
@export var areaMelee:Area3D
@export var rangedSize:float
@export var meleeSize:float

var tiroRanged = preload("res://Assets/Prefabs/Attacks/ataque_pistola.tscn")
@onready var pistola_timer: Timer = $pistolaTimer
@onready var pistola_attack_timer: Timer = $pistolaTimer/pistolaAttackTimer
@onready var area_ranged: EffectArea = $areaRanged

@export var pistola_atk_speed = 1.5
var pistola_ammo = 0
var pistola_base_ammo = 1

var waiting_for_enemy:bool = true

var enemies_close = []
var enemies_far = []

func _ready() -> void:
	areaRanged.get_child(0).shape.radius = rangedSize
	areaRanged.get_child(0).shape.radius = meleeSize
	attack()

func attack() -> void:
	pistola_timer.wait_time = pistola_atk_speed
	if pistola_timer.is_stopped(): pistola_timer.start()


func _on_pistola_timer_timeout() -> void:
	pistola_ammo += pistola_base_ammo
	pistola_attack_timer.start()

func _on_pistola_attack_timer_timeout() -> void:
	if pistola_ammo > 0 and area_ranged.bodies.size() > 0:
		var pistola_atk = tiroRanged.instantiate()
		pistola_atk.position = player.position
		pistola_atk.target = area_ranged.get_body_by_dist(player.global_position).global_position
		add_child(pistola_atk)
		print("ataque instanciado")
		pistola_ammo -= 1
	if pistola_ammo > 0: pistola_attack_timer.start()
	else: pistola_attack_timer.stop()

func cancel_attack() -> void:
	waiting_for_enemy = true
