extends Node
class_name Modifier

enum TYPE { FLAT, PERCENT, BASE_PERCENT }
var type:TYPE

var value:float:
	get():
		return value * stacks

var duration:float = 0 #0 will default to infinite duration
var duration_timer:float
var stacks:int = 1 #will always have a base of 1 stack
var can_stack:bool = false
var remove_stack_on_timeout:bool = false

signal value_changed(new_value)
signal force_remove(this)

func _ready() -> void:
	if duration == 0: set_process(false)

func _process(delta: float) -> void:
	if duration_timer > 0: duration_timer -= delta
	elif duration_timer <= 0:
		duration_timer = 0
		if remove_stack_on_timeout and stacks > 1:
			stacks -= 1
			duration_timer = duration
			value_changed.emit(value * stacks)
		else: remove()

func start_timer() -> void:
	duration_timer = duration

func remove() -> void:
	force_remove.emit(self)
	queue_free()
