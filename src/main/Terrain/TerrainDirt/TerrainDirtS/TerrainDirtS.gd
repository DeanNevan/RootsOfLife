extends TerrainDirt
class_name TerrainDirtS

func _ready():
	super._ready()
	water_per_hour = Config.DIRT_S_WATER
	hint_title = "浅层泥土"
	hint_content = "有很少水分(每米根系+%.1f/h)\n你可以在这里建造根系" % water_per_hour
