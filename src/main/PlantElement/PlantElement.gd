extends Node2D
class_name PlantElement

@onready var _PolygonBorder = %PolygonBorder
@onready var _OriginAreaTexture = %OriginAreaTexture
@onready var _Texture = %Texture
@onready var _PolygonTexture = %PolygonTexture
@onready var _DetectArea = %DetectArea
@onready var _OriginArea = %OriginArea
@onready var _LightOccluder = %LightOccluder

enum Status {
	BUILDING, 
	NORMAL
}
var status : Status = Status.BUILDING

var is_building_origin_valid := false
var is_building_collision_valid := false 
var in_detect_area_objects := []
var in_origin_area_objects := []
var is_rotating := false
var rotation_speed := 10.0

var energy_cost := 1.0

var texture_color_invalid := Color.RED

func _unhandled_input(event):
	if status == Status.BUILDING:
		if event is InputEventKey:
			if event.keycode == KEY_E:
				is_rotating = event.pressed
				rotation_speed = 100.0
			elif event.keycode == KEY_Q:
				is_rotating = event.pressed
				rotation_speed = -100.0

func _process(_delta):
	if is_rotating and status == Status.BUILDING:
		rotation_degrees += _delta * rotation_speed
		Audio.play_scroll()

func set_status(_status : Status):
	status = _status
	if status == Status.BUILDING:
		modulate.a = 0.5
	elif status == Status.NORMAL:
		modulate.a = 1

func begin_build():
	_OriginAreaTexture.show()
	_DetectArea.monitoring = true
	_OriginArea.monitoring = true
	set_status(Status.BUILDING)
	update_building_view()

func finish_build():
	_OriginAreaTexture.hide()
	_DetectArea.monitoring = false
	_OriginArea.monitoring = false
	set_status(Status.NORMAL)
	_Texture.modulate = Color.WHITE

func can_build() -> bool:
	return is_building_collision_valid && is_building_origin_valid

func check_origin_valid() -> bool:
	return false

func check_building_collsion() -> bool:
	return false

func update_building_view():
	if is_building_collision_valid:
		_Texture.modulate = Color.WHITE
	else:
		_Texture.modulate = texture_color_invalid
	if is_building_origin_valid:
		_OriginAreaTexture.modulate = Color.WHITE
	else:
		_OriginAreaTexture.modulate = texture_color_invalid

func _on_origin_area_area_entered(area):
	if status != Status.BUILDING:
		return
	var object = area
	if area is DetectArea2D:
		object = area.object
	in_origin_area_objects.append(object)
	is_building_origin_valid = check_origin_valid()
	update_building_view()
	pass # Replace with function body.


func _on_origin_area_area_exited(area):
	if status != Status.BUILDING:
		return
	var object = area
	if area is DetectArea2D:
		object = area.object
	in_origin_area_objects.erase(object)
	is_building_origin_valid = check_origin_valid()
	update_building_view()
	pass # Replace with function body.


func _on_detect_area_area_entered(area):
	if status != Status.BUILDING:
		return
	var object = area
	if area is DetectArea2D:
		object = area.object
	in_detect_area_objects.append(object)
	is_building_collision_valid = check_building_collsion()
	update_building_view()
	pass # Replace with function body.


func _on_detect_area_area_exited(area):
	if status != Status.BUILDING:
		return
	var object = area
	if area is DetectArea2D:
		object = area.object
	in_detect_area_objects.erase(object)
	is_building_collision_valid = check_building_collsion()
	update_building_view()
	pass # Replace with function body.
