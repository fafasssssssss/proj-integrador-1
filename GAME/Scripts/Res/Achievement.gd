extends Resource
class_name Achievement

@export var title:String = "ACH_TITLE_DEFAULT"
@export var desc:String = "ACH_DESC_DEFAULT"

var unlocked:bool = false

func unlock() -> void:
	unlocked = true
