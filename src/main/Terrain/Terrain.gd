extends Polygon2D
class_name Terrain

var enable_texture := true:
	set(_enable_texture):
		enable_texture = _enable_texture
		if enable_texture:
			_PolygonTexture.color.a = 1
		else:
			_PolygonTexture.color.a = 0

@onready var _AreaTerrain = %AreaTerrain
@onready var _PolygonTexture = %PolygonTexture
@onready var _LineBorder = %LineBorder

# Called when the node enters the scene tree for the first time.
func _ready():
	color.a = 0
	enable_texture = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_all():
	polygon = Global.get_optimized_points(polygon)
	init_area_terrain()
	init_line_border()
	init_polygon_texture()

func init_area_terrain():
	for i in _AreaTerrain.get_children():
		i.queue_free()
	var collision_shape := CollisionPolygon2D.new()
	collision_shape.polygon = polygon
	_AreaTerrain.add_child(collision_shape)

func init_line_border():
	_LineBorder.points = polygon
	if _LineBorder.points.size() != 0:
		_LineBorder.add_point(_LineBorder.points[0])

func init_polygon_texture():
	_PolygonTexture.polygon = polygon
