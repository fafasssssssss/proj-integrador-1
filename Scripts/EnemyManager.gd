extends Node
class_name EnemyManager

var maxCount:int = 40
var enemyCount:int = 0

func check_count() -> bool:
	if enemyCount >= maxCount: return false
	else: return true
