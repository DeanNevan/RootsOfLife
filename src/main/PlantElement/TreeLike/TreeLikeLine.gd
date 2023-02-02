extends Line2D
class_name TreeLikeLine

enum Status {
	BUILDING, 
	NORMAL
}
var status : Status = Status.BUILDING

@onready var _SubLines = %SubLines
@onready var _AreaLine = %AreaLine
@onready var _LineTexture = %LineTexture
@onready var _LineTextureBorder = %LineTextureBorder

var parent_line : TreeLikeLine

# Called when the node enters the scene tree for the first time.
func _ready():
	default_color.a = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_status(_status : Status):
	status = _status
	if status == Status.BUILDING:
		modulate.a = 0.5
	elif status == Status.NORMAL:
		modulate.a = 1

func set_points(_points : PackedVector2Array):
	points = _points
	update_line_texture()

func begin_build():
	set_status(Status.BUILDING)
	_AreaLine.monitorable = false
	_AreaLine.monitoring = false

func finish_build():
	set_status(Status.NORMAL)
	_AreaLine.monitorable = true
	_AreaLine.monitoring = true
	update_line_texture()
	init_line_area()

func update_line_texture():
	_LineTexture.points = points
	_LineTextureBorder.points = points
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
	sub_line.parent_line = self

func get_sub_lines() -> Array:
	return _SubLines.get_children()


func _on_area_line_mouse_entered():
	print("!!!")
	pass # Replace with function body.
