extends Node

func convert_target_position(target : Node2D, local_pos : Vector2 = Vector2()) -> Vector2:
	return convert_target_position2(target.get_viewport_transform(), target.get_global_transform(), local_pos)

func convert_target_position2(target_viewport_transform : Transform2D, target_global_transform : Transform2D, local_pos : Vector2 = Vector2()) -> Vector2:
	var result : Vector2 = target_viewport_transform * (target_global_transform * local_pos)
	return result

func is_points_in_rect2(rect : Rect2, points : Array) -> bool:
	for i in points:
		if !rect.has_point(i):
			return false
	return true

func get_all_children(node : Node) -> Array:
	var nodes := []
	_step_get_children(node, nodes)
	return nodes

func _step_get_children(node : Node, nodes : Array):
	for i in node.get_children():
		nodes.append(i)
		_step_get_children(i, nodes)

func get_optimized_points(points : PackedVector2Array) -> PackedVector2Array:
	var result := PackedVector2Array()
	var last_vector : Vector2
	for i in points:
		if last_vector != i:
			result.append(i)
		last_vector = i
	return result

func get_center_position_in_polygon(polygon : PackedVector2Array) -> Vector2:
	var vector := Vector2()
	for i in polygon:
		vector += i
	return vector / polygon.size()
