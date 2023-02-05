extends SubViewport


@export var tilemap_path : NodePath
var tilemap : TileMap
@export var texturerect_path : NodePath
var texturerect : TextureRect
@export var following_camera_path : NodePath
var following_camera : Camera2D
@onready var camera = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap = get_node(tilemap_path)
	texturerect = get_node(texturerect_path)
	following_camera = get_node(following_camera_path)
	get_parent().get_viewport().connect("size_changed", _on_viewport_size_changed)
	_on_viewport_size_changed()
	

func init_all():
	if is_instance_valid(tilemap) and is_instance_valid(texturerect):
		var vp_tex = self.get_texture()
		texturerect.texture = vp_tex

func _on_viewport_size_changed():
	size = get_parent().get_viewport().size

func _process(_delta):
	if is_instance_valid(following_camera):
		camera.position = following_camera.position
		camera.zoom = following_camera.zoom
