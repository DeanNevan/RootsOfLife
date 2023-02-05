extends TerrainDirt
class_name TerrainDirtL

func _ready():
	super._ready()
	water_per_hour = Config.DIRT_L_WATER
	hint_title = "深层泥土"
	hint_content = "有比较多水分(每米根系+%.1f/h)\n你可以在这里建造根系" % water_per_hour
