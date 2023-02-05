extends TerrainNutrition
class_name TerrainNutritionP

func _init():
	hint_title = "磷"

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	update_hint_content()

func start_work():
	super.start_work()
	if !is_working:
		Data.nutrition_p.level += 1
		is_working = true
	pass

func stop_work():
	super.stop_work()
	if is_working:
		Data.nutrition_p.level -= 1
		is_working = false
	pass

func _on_hour_passed():
	if is_working:
		capacity -= SPEED
	if capacity <= 0:
		emit_signal("emptied", self)
		stop_work()
	pass
