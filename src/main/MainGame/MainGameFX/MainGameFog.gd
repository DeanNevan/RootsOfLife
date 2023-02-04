extends SubViewport


@export var initial_visibility_path : NodePath
var initial_visibility : Polygon2D
@export var following_camera_path : NodePath
var following_camera : Camera2D
@onready var camera = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_visibility = get_node(initial_visibility_path)
	following_camera = get_node(following_camera_path)
	get_parent().get_viewport().connect("size_changed", _on_viewport_size_changed)
	_on_viewport_size_changed()
	
	if is_instance_valid(initial_visibility):
		var new_line = $Line2D
		new_line.position = initial_visibility.position
		var points = initial_visibility.polygon
		points.append(points[0])
		new_line.points = points
		self.add_child(new_line)

func _on_viewport_size_changed():
	size = get_parent().get_viewport().size

func _process(_delta):
	if is_instance_valid(following_camera):
		camera.position = following_camera.position
		camera.zoom = following_camera.zoom
