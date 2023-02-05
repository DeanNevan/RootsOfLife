extends Terrain
class_name TerrainNutrition

signal emptied(terrain)

var SPEED := 5

var is_working := false
var in_area_roots_lines := []

@export var max_capacity := 200
@onready var capacity : int = max_capacity:
	set(_capacity):
		capacity = _capacity
		capacity = clamp(capacity, 0, max_capacity)
		update_hint_content()

func _init():
	hint_title = "营养"

func init_all():
	super.init_all()
	capacity = max_capacity

func _ready():
	super._ready()
	GameTime.connect("hour_passed", _on_hour_passed)
	pass

func start_work():
	Audio.play_open()
	pass

func stop_work():
	pass

func _on_hour_passed():
	pass

func update_hint_content():
	hint_content = "-提供营养元素，但储量有限\n-根系只要接触，+1级营养\n-储量：%d(每小时-%d)" % [capacity, SPEED]
	if is_instance_valid(GUI._FloatWindow):
		if GUI._FloatWindow.current_asker == self:
			GUI._FloatWindow.activate(self, hint_title, hint_content)
	pass

func _on_area_terrain_area_entered(area):
	var object : Object = area
	if area is DetectArea2D:
		object = area.object
	if object is RootsLine:
		in_area_roots_lines.append(object)
		start_work()
	pass # Replace with function body.


func _on_area_terrain_area_exited(area):
	var object : Object = area
	if area is DetectArea2D:
		object = area.object
	if object is RootsLine:
		in_area_roots_lines.erase(object)
		if in_area_roots_lines.size() == 0:
			stop_work()
	pass # Replace with function body.
