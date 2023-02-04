extends TerrainNutrition
class_name TerrainNutritionK

func _init():
	hint_title = "钾"
# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	update_hint_content()

func start_work():
	if !is_working:
		Data.nutrition_k.level += 1
		is_working = true
	pass

func stop_work():
	if is_working:
		Data.nutrition_k.level -= 1
		is_working = false
	pass

func _on_hour_passed():
	if is_working:
		capacity -= SPEED
	if capacity <= 0:
		emit_signal("emptied", self)
		stop_work()
	pass
