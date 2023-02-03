extends TerrainNutrition
class_name TerrainNutritionP

func _init():
	hint_title = "磷"

# Called when the node enters the scene tree for the first time.
func _ready():
	update_hint_content()
