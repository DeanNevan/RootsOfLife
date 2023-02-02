extends PlantElement
class_name TreeLike

@onready var _Origin = %Origin
@onready var _TreeLikeLines = %TreeLikeLines

var scene_line : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_origin() -> Marker2D:
	return _Origin

func add_line(line : TreeLikeLine):
	_TreeLikeLines.add_child(line)

func split_line(line, new_point, split_point_a, split_point_b) -> Array: #返回值用于设为drawing_line的parent
	var new_line_a = scene_line.instantiate()
	add_line(new_line_a)
	var new_line_b = scene_line.instantiate()
	add_line(new_line_b)
	
	var building_line = new_line_a
	for point in line.points:
		building_line.build_new_point(point)
		if point == split_point_a:
			new_line_a.build_new_point(new_point)
			new_line_b.build_new_point(new_point)
			building_line = new_line_b
	
	new_line_a.finish_build()
	new_line_b.finish_build()
	
	if line.parent_line != null:
		line.parent_line.child_lines.erase(line)
		line.parent_line.child_lines.append(new_line_a)
	new_line_a.register_child_line(new_line_b)
	for child_line in line.child_lines:
		new_line_b.register_child_line(child_line)
	
	line.queue_free()
	
	return [new_line_a, new_line_b] #可能将来b也会用到，就一起返回了
