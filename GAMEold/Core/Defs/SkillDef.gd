extends Resource
class_name SkillDef

enum TYPE { PASSIVE, BASIC, UTIL, DEF, SPECIAL, ULT }
@export var type:TYPE

@export var logic:Resource
@export var skillName:String 

@export_group("Parameters")
@export var stock:int = 1
@export var stock_to_consume:int = 1
@export var cooldown:float = 1
@export var duration:float = 0
@export_group("Flags")
@export var is_combat_skill:bool = false
@export var full_restock_on_cd:bool = false
@export var wait_for_duration_end:bool = false
@export_group("Stats")
@export var stats:Dictionary[String, Variant] = {}
