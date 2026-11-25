extends TextureRect
class_name ItemSlot

var slot_index:int
var holding_item:Item

func _get_drag_data(at_position: Vector2) -> Variant:
	return holding_item
	
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is Item
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	texture = data.texture
