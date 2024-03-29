@tool
extends Node

@export var polygon_node_path : NodePath:
	set(_polygon_node_path):
		var node : Node = get_node(_polygon_node_path)
		if node is Polygon2D:
			node.polygon = get_optimized_points(node.polygon)
		else:
			for i in get_all_children(node):
				if i is Polygon2D:
					i.polygon = get_optimized_points(i.polygon)

func get_optimized_points(points : PackedVector2Array) -> PackedVector2Array:
	var result := PackedVector2Array()
	var last_vector : Vector2
	for i in points:
		if last_vector != i:
			result.append(i)
		last_vector = i
	return result

func get_all_children(node : Node) -> Array:
	var nodes := []
	_step_get_children(node, nodes)
	return nodes

func _step_get_children(node : Node, nodes : Array):
	for i in node.get_children():
		nodes.append(i)
		_step_get_children(i, nodes)
