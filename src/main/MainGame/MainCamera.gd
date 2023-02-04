# @category: Utils/Camera/GCCCamera2D
extends Camera2D

# Configuration
@export var MAX_ZOOM := 10.0
@export var MIN_ZOOM := 0.16 

@export var zoom_gesture = 1
@export var rotation_gesture = 0
@export var movement_gesture = 1

@export var move_event_speed := 10.0

func _set_position(p):
	var position_max_limit
	var position_min_limit
	var camera_size = get_camera_size()*1.0/zoom

	if anchor_mode == ANCHOR_MODE_FIXED_TOP_LEFT:
		position_max_limit = Vector2(limit_right, limit_bottom) - camera_size
		position_min_limit = Vector2(limit_left , limit_top)
	elif anchor_mode ==  ANCHOR_MODE_DRAG_CENTER:
		position_max_limit = Vector2(limit_right, limit_bottom) - camera_size / 2
		position_min_limit = Vector2(limit_left , limit_top) + camera_size / 2
  
	if(position_max_limit < position_min_limit):
		return false

	position = p
	
	print(position_max_limit)
	print(position_min_limit)

	if(position.x > position_max_limit.x):
		position.x = position_max_limit.x
	if(position.x < position_min_limit.x):
		position.x = position_min_limit.x
	if(position.y > position_max_limit.y):
		position.y = position_max_limit.y
	if(position.y < position_min_limit.y):
		position.y = position_min_limit.y

	# print(position)
	# print("max limits: ", position_max_limit )
	# print("min limits: ", position_min_limit)

	return true

func _ready():
	InputManager.connect("any_gesture", _on_input)

func _process(_delta):
	if Input.is_action_pressed("view_up"):
		_set_position(position - (Vector2(0, move_event_speed)*1.0/zoom).rotated(rotation))
	if Input.is_action_pressed("view_down"):
		_set_position(position - (Vector2(0, -move_event_speed)*1.0/zoom).rotated(rotation))
	if Input.is_action_pressed("view_right"):
		_set_position(position - (Vector2(-move_event_speed, 0)*1.0/zoom).rotated(rotation))
	if Input.is_action_pressed("view_left"):
		_set_position(position - (Vector2(move_event_speed, 0)*1.0/zoom).rotated(rotation))

func _on_input(_sig : String, e : InputEvent):
	if (e is InputEventMultiScreenDrag and movement_gesture == 2) or (e is InputEventSingleScreenDrag and  movement_gesture == 1):
		_move(e)
	elif e is InputEventScreenTwist and rotation_gesture == 1:
		_rotate(e)
	elif e is InputEventScreenPinch and zoom_gesture == 1:
		_zoom(e)
	pass


# Given a a position on the camera returns to the corresponding global position
func camera2global(position):
	var camera_center = global_position + position
	var from_camera_center_pos = position - get_camera_center_offset()
	return camera_center + (from_camera_center_pos*1.0/zoom).rotated(rotation)

func _move(event):
	_set_position(position - (event.relative*1.0/zoom).rotated(rotation))

func _zoom(event):
	var li = event.distance
	var lf = event.distance + event.relative
	var zi = 1.0/zoom.x
	
	var zf = (li*zi)/lf
	if zf == 0: return
	var zd = zf - zi
	
	if zf <= MIN_ZOOM and sign(zd) < 0:
		zf =MIN_ZOOM
		zd = zf - zi
	elif zf >= MAX_ZOOM and sign(zd) > 0:
		zf = MAX_ZOOM
		zd = zf - zi
	
	var from_camera_center_pos = event.position - get_camera_center_offset()
	zoom = 1.0/zf*Vector2.ONE
	if(!_set_position(position - (from_camera_center_pos*zd).rotated(rotation))):
		zoom = 1.0/zi*Vector2.ONE

func _rotate(event):
	var fccp = (event.position - get_camera_center_offset()) # from_camera_center_pos = fccp
	var fccp_op_rot =  -fccp.rotated(event.relative)
	_set_position(position - ((fccp_op_rot + fccp)*1.0/zoom).rotated(rotation-event.relative))
	rotation -= event.relative

func get_camera_center_offset():
	if anchor_mode == ANCHOR_MODE_FIXED_TOP_LEFT:
		return Vector2.ZERO
	elif anchor_mode ==  ANCHOR_MODE_DRAG_CENTER:
		return get_camera_size()/2

func get_camera_size():
	return get_viewport().get_visible_rect().size
