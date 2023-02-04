extends TerrainDirt
class_name TerrainDirtM

func _init():
	water_per_hour = 2
	hint_title = "普通泥土"
	hint_content = "有一定水分(每米根系+%d/h)\n你可以在这里建造根系" % water_per_hour

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
