extends Area2D
class_name DetectArea2D

@export var object_node_path : NodePath
var object : Object = null

func _ready():
	object = get_node(object_node_path)
