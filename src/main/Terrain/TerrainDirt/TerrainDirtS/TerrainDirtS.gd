extends TerrainDirt
class_name TerrainDirtS

func _init():
	water_per_hour = 1
	hint_title = "浅层泥土"
	hint_content = "有很少的水分(每米根系+%d/h)\n你可以在这里建造根系" % water_per_hour

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
