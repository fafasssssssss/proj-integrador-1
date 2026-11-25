extends PlayerComponent
class_name PlayerMove

#Movement
var input_dir : Vector2 = Vector2(1,0)
var cached_dir: Vector2 = Vector2(1,0)
var mov_dir : Vector3

#Dash
var dash_timer : float
var dash_reload_timer : float
var dash_duration:float
var dash_speed:float

signal direction_changed(dir)

func _physics_process(delta: float) -> void:
	gravity(delta)
	if player.get_state() != "STUNNED":
		movement(delta)

func movement(_delta: float) -> void:
	#get input direction
	input_dir = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	#cache direction
	if input_dir != Vector2(0,0): #Standing still
		if cached_dir and input_dir.x != cached_dir.x: direction_changed.emit(input_dir.x)
		cached_dir = input_dir
	elif player.get_state() != "DASHING": player.set_state("IDLE")
	#do stuff
	mov_dir = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	match player.get_state():
		"DASHING":
			if cached_dir:
				player.velocity.x = cached_dir.x * (player.stats.mov_speed * player.stats.dash_speed)
				player.velocity.z = cached_dir.y * (player.stats.mov_speed * player.stats.dash_speed)
			else: stop_moving()
		"IDLE":
			if mov_dir:
				player.set_state("MOVING")
				player.velocity.x = mov_dir.x * (player.stats.mov_speed)
				player.velocity.z = mov_dir.z * (player.stats.mov_speed)
			else: stop_moving()
		"MOVING":
			if mov_dir:
				player.velocity.x = mov_dir.x * (player.stats.mov_speed)
				player.velocity.z = mov_dir.z * (player.stats.mov_speed)
			else: stop_moving()
		_:
			stop_moving()

	player.move_and_slide()

func gravity(_delta:float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * _delta

func stop_moving() -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, (player.stats.mov_speed))
	player.velocity.z = move_toward(player.velocity.z, 0, (player.stats.mov_speed))
