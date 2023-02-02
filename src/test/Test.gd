extends Node2D

enum DrawingType{
	ROOTS,
	STEM
}

var drawing_line_parent : TreeLikeLine
var drawing_line : TreeLikeLine
var is_drawing := false
var drawing_type := DrawingType.ROOTS
var drawing_safe_position := Vector2()
var is_drawing_meet_collision := false
var drawing_unsafe_objects := []

var areas := []
var tree_like_lines_shapes := {}

var scene_roots_line : PackedScene = preload("res://src/main/PlantElement/TreeLike/Roots/RootsLine.tscn")

@onready var _AreaMouseDrawer = %AreaMouseDrawer
@onready var _TimerDrawing = %TimerDrawing
@onready var _RayDrawing = %RayDrawing

func _ready():
	$Roots/TreeLikeLines/RootsLine.finish_build()
	$TerrainBarrier.init_all()

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				request_start_draw_roots_line()
			else:
				request_stop_draw_roots_line()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	_AreaMouseDrawer.global_position = get_global_mouse_position()
	pass

func request_start_draw_roots_line():
	var closet_distance : float = 999
	var closet_point := Vector2()
	drawing_line_parent = null
	for i in tree_like_lines_shapes:
		if i is RootsLine:
			for j in tree_like_lines_shapes[i]:
				if !is_instance_valid(j):
					continue
				var segment_shape : SegmentShape2D = j.shape
				var _point : Vector2 = Geometry2D.get_closest_point_to_segment(
					get_global_mouse_position(),
					segment_shape.a,
					segment_shape.b
				)
				var distance : float = (_point - get_global_mouse_position()).length()
				if distance < closet_distance:
					drawing_line_parent = i
					closet_point = _point
	if !is_instance_valid(drawing_line_parent):
		return
	is_drawing = true
	drawing_type = DrawingType.ROOTS
	drawing_line = scene_roots_line.instantiate()
	add_child(drawing_line)
	drawing_line.build_new_point(closet_point)
	drawing_line.begin_build()
	drawing_safe_position = closet_point
	_TimerDrawing.start()
	_AreaMouseDrawer.get_node("CollisionShape2D").shape.radius = 5
	pass

func request_stop_draw_roots_line():
	if !is_drawing:
		return
	_AreaMouseDrawer.get_node("CollisionShape2D").shape.radius = 10
	is_drawing = false
	if is_instance_valid(drawing_line):
		if !is_instance_valid(drawing_line_parent):
			drawing_line.queue_free()
			return
		drawing_line.finish_build()
		remove_child(drawing_line)
		drawing_line_parent.add_sub_line(drawing_line)
	drawing_line = null
	drawing_line_parent = null
	pass

func _on_area_mouse_drawer_area_entered(area):
	areas.append(area)
	var object = area
	if area is DetectArea2D:
		object = area.object
	if object is TerrainBarrier or object is TreeLikeLine:
		drawing_unsafe_objects.append(object)
		is_drawing_meet_collision = true
	pass # Replace with function body.


func _on_area_mouse_drawer_area_exited(area):
	areas.erase(area)
	var object = area
	if area is DetectArea2D:
		object = area.object
	if drawing_unsafe_objects.has(object):
		drawing_unsafe_objects.erase(object)
		if drawing_unsafe_objects.size() == 0:
			is_drawing_meet_collision = false
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


func _on_timer_drawing_timeout():
	if is_drawing:
		if is_instance_valid(drawing_line):
			if drawing_line.points.size() <= 1:
				drawing_safe_position = get_global_mouse_position()
				drawing_line.build_new_point(drawing_safe_position)
			else:
				if !is_drawing_meet_collision:
					var vector : Vector2 = get_global_mouse_position() - _RayDrawing.global_position
					_RayDrawing.global_position = drawing_safe_position + vector.normalized()
					_RayDrawing.target_position = get_global_mouse_position() - _RayDrawing.global_position
					_RayDrawing.force_raycast_update()
					var is_safe := true
					if _RayDrawing.is_colliding():
						var area = _RayDrawing.get_collider()
						var object = area
						if area is DetectArea2D:
							object = area.object
						if object is TerrainBarrier or object is TreeLikeLine:
							is_safe = false
					if is_safe:
						drawing_safe_position = get_global_mouse_position()
						drawing_line.build_new_point(drawing_safe_position)
		_TimerDrawing.start()
	pass # Replace with function body.
