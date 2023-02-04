extends TerrainDirt
class_name TerrainDirtL

func _init():
	water_per_hour = 3
	hint_title = "深层泥土"
	hint_content = "有比较多水分(每米根系+%d/h)\n你可以在这里建造根系" % water_per_hour
