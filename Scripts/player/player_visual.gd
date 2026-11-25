extends PlayerComponent

@export var sprite_top : Sprite3D
@export var sprite_bot : Sprite3D

func flip_sprite() -> void:
	sprite_top.flip_h = !sprite_top.flip_h
	sprite_bot.flip_h = !sprite_bot.flip_h
	
func get_flipped() -> bool:
	if sprite_top.flip_h: return true
	else: return false
