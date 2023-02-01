extends Line2D
class_name StemLine

@onready var _SubStemLines = %SubStemLines
@onready var _Leaves = %Leaves
@onready var _AreaLine = %AreaLine

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_area_line():
	for i in _AreaLine.get_children():
		i.queue_free()
	for i in points.size() - 1:
		var collision_shape := CollisionShape2D.new()
		var segment_shape := SegmentShape2D.new()
		segment_shape.a = points[i]
		segment_shape.b = points[i + 1]
		collision_shape.shape = segment_shape
		_AreaLine.add_child(collision_shape)

func add_sub_stem_line(sub_stem_line : StemLine):
	_SubStemLines.add_child(sub_stem_line)

func add_leaf(leaf : Leaf):
	_Leaves.add_child(leaf)

func get_sub_stem_line() -> Array:
	return _SubStemLines.get_children()

func get_leaves() -> Array:
	return _Leaves.get_children()

func _on_area_line_area_entered(area):
	pass # Replace with function body.
