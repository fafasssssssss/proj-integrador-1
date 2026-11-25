extends Node
class_name SkillLogic

var base:SkillDef
@onready var player:PlayerMaster

var timer_duration:float = -1
var timer_cooldown:float = -1 #negative value to avoid errors on start
@onready var max_stock:int = base.stock
@onready var stock:int = max_stock

var has_duration:bool = true
var has_cooldown:bool = true
var in_use:bool = false
var on_cooldown:bool = false

var input_map:InputEventAction#IMPLEMENTAR ISSO

signal duration_ended
signal cooldown_ended

func _init(_player, _base) -> void:
	player = _player
	base = _base
	if base.duration > 0:
		has_duration = true
		duration_ended.connect(_on_end)
	if base.cooldown > 0:
		has_cooldown = true
		cooldown_ended.connect(_on_cooldown_end)

func _on_use():
	in_use = true
	stock -= base.stock_to_consume
	_logic()
	if has_cooldown and !base.wait_for_duration_end: start_cooldown()
	if has_duration: timer_duration = base.duration
	else: _on_end()

func _logic():
	#Write skill code in here
	pass

func _on_end():
	in_use = false
	if has_cooldown and base.wait_for_duration_end: start_cooldown()

func _physics_process(delta: float) -> void:
	timers(delta)

func timers(delta:float):
	if has_duration and timer_duration > 0:
		timer_duration = max(0.0, timer_duration - delta)
	if has_cooldown and timer_cooldown > 0:
		timer_cooldown = max(0.0, timer_cooldown - delta)
		
	if has_duration and timer_duration == 0:
		timer_duration = -1
		duration_ended.emit()
	if has_cooldown and timer_cooldown == 0:
		timer_cooldown = -1
		cooldown_ended.emit()

func start_cooldown():
	timer_cooldown = base.cooldown
	on_cooldown = true

func _on_cooldown_end():
	if base.full_restock_on_cd: stock = max_stock
	else: stock = max(max_stock, stock + 1)

func can_use() -> bool:
	if stock < base.stock_to_consume: return false
	else: return true
