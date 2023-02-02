extends Node2D

var drawing_line_parent : TreeLikeLine
var drawing_line : TreeLikeLine
var is_drawing := false

var areas := []
var tree_like_lines_shapes := {}

@onready var _AreaMouseDrawer = %AreaMouseDrawer

func _ready():
	$Roots/TreeLikeLines/RootsLine.finish_build()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_mask == MOUSE_BUTTON_LEFT:
			if event.pressed:
				request_start_draw_roots_line()
			else:
				request_stop_draw_roots_line()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_AreaMouseDrawer.global_position = get_global_mouse_position()
	pass

func request_start_draw_roots_line():
	var closet_distance : float = 999
	drawing_line_parent = null
	if is_instance_valid(drawing_line):
		drawing_line.queue_free()
	for i in tree_like_lines_shapes:
		if i is RootsLine:
			for j in tree_like_lines_shapes[i]:
				var segment_shape : SegmentShape2D = tree_like_lines_shapes[i][j]
				var closed_point = Geometry2D.get_closest_point_to_segment(
					get_global_mouse_position(),
					segment_shape.a,
					segment_shape.b
				)
	pass

func request_stop_draw_roots_line():
	pass

func _on_area_mouse_drawer_area_entered(area):
	areas.append(area)
	pass # Replace with function body.


func _on_area_mouse_drawer_area_exited(area):
	areas.erase(area)
	pass # Replace with function body.


func _on_area_mouse_drawer_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area is DetectArea2D:
		if area.object is TreeLikeLine:
			if tree_like_lines_shapes.get(area.object) == null:
				tree_like_lines_shapes[area.object] = []
			tree_like_lines_shapes[area.object].append(area.get_child(area_shape_index))
	pass # Replace with function body.


func _on_area_mouse_drawer_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area is DetectArea2D:
		if area.object is TreeLikeLine:
			if tree_like_lines_shapes.get(area.object) != null:
				tree_like_lines_shapes[area.object].erase(area.get_child(area_shape_index))
	pass # Replace with function body.
