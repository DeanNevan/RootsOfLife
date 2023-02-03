@tool
extends Node

@export var polygon_node_path : NodePath:
	set(_polygon_node_path):
		var polygon : Polygon2D = get_node(_polygon_node_path)
		if polygon != null:
			polygon.polygon = get_optimized_points(polygon.polygon)

func get_optimized_points(points : PackedVector2Array) -> PackedVector2Array:
	var result := PackedVector2Array()
	var last_vector : Vector2
	for i in points:
		if last_vector != i:
			result.append(i)
		last_vector = i
	return result
