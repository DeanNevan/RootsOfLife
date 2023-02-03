extends Terrain
class_name TerrainDirt

var water_per_hour := 0

func _init():
	hint_title = "泥土"
	hint_content = "有水分(+%d/h)\n你可以在这里建造根系" % water_per_hour

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
