extends MarginContainer

@onready var _Plate = %Plate
@onready var _Pointer = %Pointer
@onready var _Panel = %Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	_on_resized()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_Plate.rotation = PI + GameTime.get_percent_in_day() * 2 * PI
	pass


func _on_resized():
	if is_instance_valid(_Plate) and is_instance_valid(_Pointer) and is_instance_valid(_Panel):
		_Panel.pivot_offset = _Panel.size / 2
		_Plate.pivot_offset = _Plate.size / 2
		_Pointer.pivot_offset = _Pointer.size / 2
		print(_Plate.size)
	pass # Replace with function body.
