extends TerrainDirt
class_name TerrainDirtM

func _ready():
	super._ready()
	water_per_hour = Config.DIRT_M_WATER
	hint_title = "普通泥土"
	hint_content = "-有一定水分(每米根系+%.1f/h)\n-你可以在这里建造根系" % water_per_hour
