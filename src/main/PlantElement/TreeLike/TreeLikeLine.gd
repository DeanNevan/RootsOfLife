extends Line2D
class_name TreeLikeLine

enum Status {
	BUILDING, 
	NORMAL
}
var status : Status = Status.BUILDING


@onready var _FogSprite = get_node("/root/Test/FogSprite")
@onready var _AreaLine = %AreaLine
@onready var _LineTexture = %LineTexture
@onready var _LineTextureBorder = %LineTextureBorder

var parent_line : TreeLikeLine
var child_lines := []
var thickness = 0.0:
	set(_thickness):
		thickness = _thickness
		self.width = calculate_width(_thickness)
		_LineTexture.width = calculate_width(_thickness)
		_LineTextureBorder.width = calculate_width(_thickness) + 5

# Called when the node enters the scene tree for the first time.
func _ready():
	default_color.a = 0
	
	thickness = calculate_length()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func defog(): #似乎不行，没有有效的在image上绘制的手段
	for i in range(points.size() - 1):
		var point_a = points[i]
		var point_b = points[i + 1]
		#_FogSprite.fog_image
	_FogSprite.update_image()

func calculate_width(_length) -> float:
	return pow(_length * 0.01, 0.75)

func calculate_length() -> float:
	var _length = 0.0
	for i in range(points.size() - 1):
		_length += points[i].distance_to(points[i + 1])
	return _length

func set_status(_status : Status):
	status = _status
	if status == Status.BUILDING:
		modulate.a = 0.5
	elif status == Status.NORMAL:
		modulate.a = 1

func begin_build():
	set_status(Status.BUILDING)

func finish_build():
	set_status(Status.NORMAL)
	update_line_texture()
	init_line_area()

func update_line_texture():
	_LineTexture.points = points
	_LineTextureBorder.points = points
	pass

func build_new_point(_point : Vector2):
	add_point(_point)
	update_line_texture()
	if points.size() > 1:
		var collision_shape := CollisionShape2D.new()
		var segment_shape := SegmentShape2D.new()
		segment_shape.a = points[points.size() - 2]
		segment_shape.b = points[points.size() - 1]
		collision_shape.shape = segment_shape
		_AreaLine.add_child(collision_shape)
	if points.size() > 1:
		# 最后一个点和倒数第二个点连线长度
		var length = points[points.size() - 1].distance_to(points[points.size() - 2])
		widen(length)

func widen(added_thickness):
	thickness = thickness + added_thickness
	
	if is_instance_valid(parent_line):
		parent_line.widen(added_thickness)

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

func register_child_line(child_line : TreeLikeLine):
#	_SubLines.add_child(sub_line)
	child_line.parent_line = self
	self.child_lines.append(child_line)

func get_all_child_lines() -> Array:
	var nodes := []
	_step_get_all_child_lines(self, nodes)
	return nodes

func _step_get_all_child_lines(node : Node, nodes : Array):
	for i in node.child_lines:
		nodes.append(i)
		_step_get_all_child_lines(i, nodes)
