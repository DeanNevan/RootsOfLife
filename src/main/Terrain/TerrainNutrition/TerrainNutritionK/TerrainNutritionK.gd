extends TerrainNutrition
class_name TerrainNutritionK

func _init():
	hint_title = "钾"

# Called when the node enters the scene tree for the first time.
func _ready():
	update_hint_content()
