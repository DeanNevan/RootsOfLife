extends PlantElement
class_name Leaf

func _init():
	texture_color_invalid = Color(1, 0, 0.01568627543747)

func check_origin_valid() -> bool:
	for i in in_origin_area_objects:
		if i is StemLine:
			return true
	return false

func check_building_collsion() -> bool:
	print(in_detect_area_objects)
	for i in in_detect_area_objects:
		if i is StemLine or i is TerrainBarrier or i is RootsLine or i is Leaf or i is StorageRoots:
			return false
	return true
