extends PlantElement
class_name Leaf

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func check_origin_valid() -> bool:
	for i in in_origin_area_objects:
		if i is StemLine:
			return true
	return false

func check_building_collsion() -> bool:
	for i in in_detect_area_objects:
		if !(i is TerrainDirt):
			return false
	return true
