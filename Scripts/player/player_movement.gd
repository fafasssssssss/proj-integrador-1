extends PlayerComponent

const BASE_SPEED : float = 5
var input_dir : Vector2 = Vector2(1,0)
var mov_dir : Vector3
var cached_dir: Vector2 = Vector2(1,0)
var can_dash : bool = true
var dash_timer : float
var dash_reload : float

func _physics_process(delta: float) -> void:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta
	movement(delta)

func movement(delta: float) -> void:
	input_dir = Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	if input_dir != Vector2(0,0):
		cached_dir = input_dir
		check_directon(input_dir.x)
	mov_dir = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	if mov_dir:
		player.velocity.x = mov_dir.x * (player.stats.mov_speed * BASE_SPEED)
		player.velocity.z = mov_dir.z * (player.stats.mov_speed * BASE_SPEED)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, (player.stats.mov_speed * BASE_SPEED))
		player.velocity.z = move_toward(player.velocity.z, 0, (player.stats.mov_speed * BASE_SPEED))
	
	_dash_logic(delta)	
	#if input_dir != Vector2(-1,0) and input_dir != Vector2(1,0):
		#player.velocity *= 1
	#print(player.velocity.length())
	player.move_and_slide()
	collide_with_enemies(delta)

func _dash_logic(delta: float) -> void:
	if can_dash and Input.is_action_just_pressed("dash"):
		can_dash = false
		dash_timer = player.stats.dash_duration
		dash_reload = player.stats.dash_reload
		
	if dash_timer > 0.0:
		mov_dir = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		player.velocity.x = mov_dir.x * (player.stats.dash_speed * BASE_SPEED)
		player.velocity.z = mov_dir.z * (player.stats.dash_speed * BASE_SPEED)
		dash_timer = max(0.0, dash_timer - delta)
	elif dash_reload > 0.0: dash_reload -= delta
	else: can_dash = true 
		
func check_directon(input:float) -> void:
	if input > 0 and player.components["Visual"].get_flipped():
		player.components["Visual"].flip_sprite()
	elif input < 0 and !player.components["Visual"].get_flipped():
		player.components["Visual"].flip_sprite()

func collide_with_enemies(delta:float) -> void:
	# Empurrar inimigos ao colidir
	for i in player.get_slide_collision_count():
		var collision := player.get_slide_collision(i)
		var collider := collision.get_collider()
		
		# Verifique se o objeto colidido está no grupo "Enemies"
		if collider is RigidBody3D and collider.is_in_group("Enemies"):
			# Direção do empurrão (do player para o inimigo)
			var push_direction = -collision.get_normal()
			push_direction.y = 0 # Opcional: evita empurrar para cima/baixo
			
			# Aplica a força ao inimigo (se ele tiver uma função para receber empurrão)
			if collider.has_method("contact"):
				#collider.contact(push_direction, delta)
				pass
