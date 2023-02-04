extends PlantElement
class_name StorageRoots

var capacity_bonus := 1.0

func _init():
	texture_color_invalid = Color(1, 0.16000002622604, 0.17399978637695)

func finish_build():
	super.finish_build()
	Data.energy.capacity += capacity_bonus
	

func check_origin_valid() -> bool:
	for i in in_origin_area_objects:
		if i is RootsLine:
			return true
	return false

func check_building_collsion() -> bool:
	print(in_detect_area_objects)
	for i in in_detect_area_objects:
		if i is StemLine or i is TerrainBarrier or i is RootsLine or i is Leaf or i is StorageRoots:
			return false
	return true
