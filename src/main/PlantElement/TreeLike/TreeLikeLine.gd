extends Node2D
class_name TreeLikeLine

var points := []

@onready var _SubLines = %SubLines
@onready var _AreaLine = %AreaLine
@onready var _LineTexture = %LineTexture

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_texture_line():
	pass

func init_line_area():
	for i in _AreaLine.get_children():
		i.queue_free()
	for i in points.size() - 1:
		var collision_shape := CollisionShape2D.new()
		var segment_shape := SegmentShape2D.new()
		segment_shape.a = points[i]
		segment_shape.b = points[i + 1]
		collision_shape.shape = segment_shape
		_AreaLine.add_child(collision_shape)

func add_sub_line(sub_line : TreeLikeLine):
	_SubLines.add_child(sub_line)

func get_sub_lines() -> Array:
	return _SubLines.get_children()


func _on_area_line_mouse_entered():
	print("!!!")
	pass # Replace with function body.
