extends Area3D
class_name EffectArea

var bodies:Array

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)
	
func _on_body_entered(body:Node3D) -> void:
	if !bodies.has(body): bodies.append(body)
	
func _on_body_exited(body:Node3D) -> void:
	if bodies.has(body): bodies.erase(body)

func get_body_by_dist(from:Vector3, closest:bool = true) -> Node3D:	
	if closest: bodies.sort_custom(func(a, b): return from.distance_to(a.global_position) < from.distance_to(b.global_position))
	else: bodies.sort_custom(func(a, b): return from.distance_to(a.global_position) > from.distance_to(b.global_position))
	return bodies[0]
