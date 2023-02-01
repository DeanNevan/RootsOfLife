extends Line2D
class_name RootsLine

@onready var _SubRootsLines = %SubRootsLines
@onready var _StorageRoots = %StorageRoots
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

func add_sub_roots_line(sub_roots_line : RootsLine):
	_SubRootsLines.add_child(sub_roots_line)

func add_storage_roots(storage_roots : StorageRoots):
	_StorageRoots.add_child(storage_roots)

func get_sub_roots_lines() -> Array:
	return _SubRootsLines.get_children()

func get_storage_roots() -> Array:
	return _StorageRoots.get_children()

func _on_area_line_area_entered(area):
	pass # Replace with function body.
