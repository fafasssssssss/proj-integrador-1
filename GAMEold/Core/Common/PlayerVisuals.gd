extends PlayerComponent
class_name PlayerVisuals

@export var sprite:AnimatedSprite3D

var flipped:bool = false

func _ready() -> void:
	await get_tree().physics_frame
	sprite.animation = &"idle_R"
	sprite.play()
	player.get_part("Move").direction_changed.connect(flip)
	player.state_changed.connect(change_animation)
	
func change_animation(_state:String) -> void:
	match _state:
		"IDLE":
			sprite.animation = &"idle_L" if flipped else &"idle_R"
			sprite.play()
		"MOVING":
			sprite.animation = &"walking_L" if flipped else &"walking_R"
			sprite.play()
		"DASHING":
			sprite.animation = &"dash_L" if flipped else &"dash_R"
			sprite.play()

func flip(dir:float) -> void:
	print(dir)
	if dir > 0: flipped = false
	elif dir < 0: flipped = true
	change_animation(player.get_state())
