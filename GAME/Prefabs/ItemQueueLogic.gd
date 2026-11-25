extends Node

@export var debug_items:Array[Item]

var items:Array[Item]

signal items_changed(items)

func _ready() -> void:
	#DEBUG
	for i in debug_items:
		items.append(i)
	items_changed.emit()
