extends Node

func get_all_children(node : Node) -> Array:
	var nodes := []
	_step_get_children(node, nodes)
	return nodes

func _step_get_children(node : Node, nodes : Array):
	for i in node.get_children():
		nodes.append(i)
		_step_get_children(i, nodes)
