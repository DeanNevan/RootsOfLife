extends Polygon2D
class_name WorldArea

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func init_all():
	polygon = Global.get_optimized_points(polygon)
	$WorldBorder.points = polygon
	if polygon.size() != 0:
		$WorldBorder.add_point(polygon[0])
	$AreaWorld/CollisionPolygon2D.polygon = polygon
