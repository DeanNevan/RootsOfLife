extends Node

enum BuildingType {
	ROOTS_LINE,
	STORAGE_ROOTS,
	STEM_LINE,
	LEAF,
	NONE
}
enum BuildingSize {
	S,
	M,
	L,
	NONE
}

var fog_thickness = 200

func get_polyline_length(polyline : PackedVector2Array) -> float:
	var length := 0.0
	if polyline.size() >= 2:
		for i in polyline.size() - 1:
			length += (polyline[i + 1] - polyline[i]).length()
	return length

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
	var total_moment = Vector2.ZERO
	var total_mass = 0
	
	for i in range(polygon.size()):
		var point1 = polygon[i]
		var point2
		if i < polygon.size() - 1:
			point2 = polygon[i + 1]
		else:
			point2 = polygon[0]
		
		var triangle_mass = (point1.x * point2.y - point2.x * point1.y) * 0.5
		
		total_moment += (point1 + point2) * triangle_mass
		total_mass += triangle_mass
	
	return total_moment / total_mass / 3.0
