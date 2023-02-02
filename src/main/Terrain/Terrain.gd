extends Polygon2D
class_name Terrain

@onready var _PolygonTexture = %PolygonTexture

# Called when the node enters the scene tree for the first time.
func _ready():
	color.a = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_all():
	init_polygon_texture()

func init_polygon_texture():
	_PolygonTexture.polygon = polygon
	pass
