extends PlayerComponent

@export var passive_def:SkillDef
@export var basic_def:SkillDef
@export var utility_def:SkillDef
@export var defensive_def:SkillDef
@export var special_def:SkillDef
var defs:Array[SkillDef] = [passive_def,basic_def,utility_def,defensive_def,special_def]

var passive:SkillLogic
var basic:SkillLogic
var utility:SkillLogic
var defensive:SkillLogic
var special:SkillLogic
var skills:Array[SkillLogic] = [passive,basic,utility,defensive,special]

func player_ready() -> void:
	#DEBUG
	utility = utility_def.logic.new(player, utility_def)
	add_child(utility)
	return
	
	var i:int = 0
	for skill in skills:
		skill = defs[i].logic.new(player, defs[i])
		add_child(skill)
		i += 1

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("dash") and utility.can_use():
		utility._on_use()
