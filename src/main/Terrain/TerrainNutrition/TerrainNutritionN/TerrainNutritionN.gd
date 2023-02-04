extends TerrainNutrition
class_name TerrainNutritionN

func _init():
	hint_title = "氮"

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	update_hint_content()
