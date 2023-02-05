extends Line2D
class_name TreeLikeLine

signal changed(line)

enum Status {
	BUILDING, 
	NORMAL
}
var status : Status = Status.BUILDING

var fog

@onready var _AreaLine = %AreaLine
@onready var _LineTexture = %LineTexture
@onready var _LineTextureBorder = %LineTextureBorder
#@onready var _LineTextureOccluder = %LineTextureOccluder
#@onready var _LineTextureOccluder2 = %LineTextureOccluder2

var parent_line : TreeLikeLine
var child_lines := []
var thickness = 0.0:
	set(_thickness):
		thickness = _thickness
		self.width = clamp(calculate_width(_thickness), 1, 1000)
		_LineTexture.width = self.width
		_LineTextureBorder.width = self.width + 5
#		_LineTextureOccluder.width = self.width + Global.fog_thickness * 2.0
#		_LineTextureOccluder2.width = self.width + Global.fog_thickness

# Called when the node enters the scene tree for the first time.
func _ready():
	default_color.a = 0
	
	thickness = calculate_length()
	
#	self.remove_child(_LineTextureOccluder)
#	fog.add_child(_LineTextureOccluder)


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#func defog(): #似乎不行，没有有效的在image上绘制的手段
#	for i in range(points.size() - 1):
#		var point_a = points[i]
#		var point_b = points[i + 1]
#		#_FogSprite.fog_image
#	_FogSprite.update_image()

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
	#init_line_area()

func update_line_texture():
	_LineTexture.points = points
	_LineTextureBorder.points = points
#	_LineTextureOccluder.points = points
#	_LineTextureOccluder2.points = points
	pass

func get_length() -> float:
	var length := 0.0
	for i in points.size() - 1:
		length += (points[i + 1] - points[i]).length()
	return length

# 建造需要消耗能量，能量足够返回true
func build_new_point(_point : Vector2, _check_cost := false) -> bool:
	if _check_cost:
		if points.size() >= 1:
			var last_point : Vector2 = points[points.size() - 2]
			var distance : float = (_point - last_point).length()
			var cost : float = Data.energy.calculate_roots_line_cost(distance) * Config.TREE_LIKE_LINE_COST_RATE
			var result : bool = Data.energy.try_consume(cost)
			if !result:
				return false
	add_point(_point)
	update_line_texture()
	if points.size() > 1:
		var collision_shape := CollisionShape2D.new()
		var segment_shape := SegmentShape2D.new()
		segment_shape.a = points[points.size() - 2]
		segment_shape.b = points[points.size() - 1]
		collision_shape.shape = segment_shape
		_AreaLine.call_deferred("add_child", collision_shape)
	if points.size() > 1:
		# 最后一个点和倒数第二个点连线长度
		var length = points[points.size() - 1].distance_to(points[points.size() - 2])
		widen(length)
		fog.defog(points)
	emit_signal("changed", self)
	return true

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
		_AreaLine.call_deferred("add_child", collision_shape)

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
