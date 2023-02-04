extends PlantElement
class_name Leaf

signal fall_requested(leaf : Leaf)

#生命小时数
var total_life_hour := 48
var life_hour := 0

var is_falling := false

func _init():
	texture_color_invalid = Color(1, 0, 0.01568627543747)

func _ready():
	GameTime.connect("hour_passed", _on_hour_passed)

func _on_hour_passed():
	if !Data.is_pause_leaf_fall and status == Status.NORMAL and !is_falling:
		life_hour += 1
		if life_hour > total_life_hour:
			emit_signal("fall_requested", self)
	pass

func fall():
	is_falling = true
	var tween : Tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position:y", position.y + 300, 1)
	tween.tween_property(self, "modulate:a", 0, 1)
	await tween.finished
	queue_free()
	pass

func check_origin_valid() -> bool:
	for i in in_origin_area_objects:
		if i is StemLine:
			return true
	return false

func check_building_collsion() -> bool:
	#print(in_detect_area_objects)
	for i in in_detect_area_objects:
		if i is StemLine or i is TerrainBarrier or i is RootsLine or i is Leaf or i is StorageRoots:
			return false
	return true
