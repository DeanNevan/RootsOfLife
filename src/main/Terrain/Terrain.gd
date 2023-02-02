extends Polygon2D
class_name Terrain

@onready var _AreaTerrain = %AreaTerrain

# Called when the node enters the scene tree for the first time.
func _ready():
	color.a = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_all():
	polygon = Global.get_optimized_points(polygon)
	init_area_terrain()

func init_area_terrain():
	for i in _AreaTerrain.get_children():
		i.queue_free()
	var collision_shape := CollisionPolygon2D.new()
	collision_shape.polygon = polygon
	_AreaTerrain.add_child(collision_shape)
