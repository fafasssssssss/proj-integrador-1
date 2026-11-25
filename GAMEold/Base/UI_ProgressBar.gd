extends TextureProgressBar

@onready var player:PlayerMaster

@export var stat_name:String
@export var duration:float
@export var skill:bool
@export var disappear:bool = false

var tw:Tween

func _ready() -> void:
	await get_tree().physics_frame
	player = get_tree().get_first_node_in_group("Player")
	if !skill and player.stats.has_signal("value_changed"):
		player.stats.value_changed.connect(tween_value)
		print(player.stats.max_hp)
		max_value = player.stats.max_hp
		print(max_value)
		value = player.stats.hp
		print(value)
	elif skill:
		player.get_part("Skills").utility.dash_started.connect(tween_value)
		visible = false

func tween_value(_name:String, new_value:float):
	if stat_name != _name: return
	if _name == "dash":
		value = 0
		visible = true
		reset_tween()
		tw.tween_property(self, "value", 1, new_value + 0.1).set_ease(Tween.EASE_OUT)
	else:
		reset_tween()
		tw.tween_property(self, "value", new_value, duration).set_ease(Tween.EASE_OUT)
	tw.chain().finished.connect(on_end)

func on_end() -> void:
	if !skill:
		if value == min_value: visible = false
	else:
		if value == max_value: visible = false

func reset_tween() -> void:
	if tw: tw.kill()
	tw = create_tween()
