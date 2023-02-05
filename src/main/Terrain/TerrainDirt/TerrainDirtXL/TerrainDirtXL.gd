extends TerrainDirt
class_name TerrainDirtXL

func _ready():
	super._ready()
	water_per_hour = Config.DIRT_XL_WATER
	hint_title = "沃土"
	hint_content = "有很多水分(每米根系+%.1f/h)\n你可以在这里建造根系" % water_per_hour
