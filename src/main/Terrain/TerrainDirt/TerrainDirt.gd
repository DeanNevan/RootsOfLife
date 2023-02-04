extends Terrain
class_name TerrainDirt

var water_per_hour := 0.0

var effect := 0.0
var total_length_roots_line := 0.0

var in_area_roots_lines := []

func _init():
	hint_title = "泥土"
	hint_content = "有水分(+%d/h)\n你可以在这里建造根系" % water_per_hour

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_effect():
	Data.water.increase_speed -= effect
	effect = 0
	total_length_roots_line = 0
	for i in in_area_roots_lines:
		#if i.status == RootsLine.Status.NORMAL:
		var line_points : PackedVector2Array = i.points
		if line_points.size() < 2:
			continue
#		var vector : Vector2 = line_points[1] - line_points[0]
#		line_points.insert(0, line_points[0] + vector.normalized() * 10000)
#		vector = line_points[line_points.size() - 1] - line_points[line_points.size() - 2]
#		line_points.append(line_points[0] + vector.normalized() * 10000)
		var result : Array = Geometry2D.intersect_polyline_with_polygon(line_points, polygon)
		for j in result:
			total_length_roots_line += Global.get_polyline_length(j)
	effect = total_length_roots_line / 100.0 * water_per_hour
	Data.water.increase_speed += effect
	

func _on_area_terrain_area_entered(area):
	var object : Object = area
	if area is DetectArea2D:
		object = area.object
	if object is RootsLine:
		in_area_roots_lines.append(object)
		if !object.is_connected("changed", _on_roots_line_changed):
			object.connect("changed", _on_roots_line_changed)
		update_effect()
	pass # Replace with function body.


func _on_area_terrain_area_exited(area):
	var object : Object = area
	if area is DetectArea2D:
		object = area.object
	if object is RootsLine:
		in_area_roots_lines.erase(object)
		if object.is_connected("changed", _on_roots_line_changed):
			object.disconnect("changed", _on_roots_line_changed)
		update_effect()
	pass # Replace with function body.

func _on_roots_line_changed(roots_line : RootsLine):
	update_effect()
	pass
