extends Control

var slots:Array[TextureRect]

func _ready() -> void:
	for i in get_child(0).get_children():
		slots.append(i)
	

func update_visuals(itemlist:Array[Item]) -> void:
	for i in itemlist:
		slots[i.index]
