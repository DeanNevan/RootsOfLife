extends Terrain
class_name TerrainWater

var water_per_hour := 5
var is_working := false
var in_area_roots_lines := []

func _ready():
	super._ready()
	water_per_hour = Config.WATER_WATER
	hint_title = "水"
	hint_content = "-根系只要接触，提供+%.1f水分/h\n-你很幸运" % water_per_hour

func _on_area_terrain_area_entered(area):
	var object : Object = area
	if area is DetectArea2D:
		object = area.object
	if object is RootsLine:
		in_area_roots_lines.append(object)
		if !is_working:
			is_working = true
			Data.water.increase_speed += water_per_hour
	pass # Replace with function body.


func _on_area_terrain_area_exited(area):
	var object : Object = area
	if area is DetectArea2D:
		object = area.object
	if object is RootsLine:
		in_area_roots_lines.erase(object)
		if is_working and in_area_roots_lines.size() == 0:
			is_working = false
			Data.water.increase_speed -= water_per_hour
	pass # Replace with function body.
