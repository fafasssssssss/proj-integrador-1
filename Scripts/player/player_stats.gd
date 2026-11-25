extends Resource
class_name PlayerStats

@export var sprite : Texture2D

@export var mov_speed : float = 1

@export var dash_speed : float = 7
@export var dash_duration : float = 0.15
@export var dash_reload : float = 1

@export var max_hp:float = 100
var hp:float = max_hp
