extends PlantResource
class_name Nutrition

# 0,1,2
func get_level() -> int:
	var percent : float = value / capacity
	if percent < 0.333:
		return 0
	elif percent < 0.666:
		return 1
	return 2

# 0,1,2
func get_level_str() -> String:
	var level : int = get_level()
	var content := ""
	if level == 0:
		content = "缺少"
	if level == 1:
		content = "普通"
	if level == 1:
		content = "丰富"
	return content
