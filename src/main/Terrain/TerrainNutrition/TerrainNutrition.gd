extends Terrain
class_name TerrainNutrition

var SPEED := 5

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

func update_hint_content():
	hint_content = "提供营养元素，但储量有限\n根系只要接触，+%d/h\n储量：%d" % [SPEED, capacity]
	if is_instance_valid(GUI._FloatWindow):
		if GUI._FloatWindow.current_asker == self:
			GUI._FloatWindow.activate(self, hint_title, hint_content)
	pass
