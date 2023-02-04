extends PlantResource
class_name Nutrition

var level := 0:
	set(_level):
		level = _level
		emit_signal("data_changed")

# 0,1,2
func get_level_str() -> String:
	var content := ""
	if level == 0:
		content = "缺少"
	elif level == 1:
		content = "普通"
	elif level == 2:
		content = "丰富"
	elif level >= 3:
		content = "过多"
	else:
		content = "ERROR"
	return content
