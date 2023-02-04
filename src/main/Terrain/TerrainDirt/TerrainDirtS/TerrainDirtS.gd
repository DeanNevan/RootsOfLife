extends TerrainDirt
class_name TerrainDirtS

func _init():
	water_per_hour = 1
	hint_title = "浅层泥土"
	hint_content = "有很少的水分(每米根系+%d/h)\n你可以在这里建造根系" % water_per_hour
