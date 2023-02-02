extends MarginContainer

@onready var _Plate = %Plate
@onready var _Pointer = %Pointer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_Plate.rotation = PI + GameTime.get_percent_in_day() * 2 * PI
	pass


func _on_resized():
	_Plate.pivot_offset = _Plate.size / 2
	_Pointer.pivot_offset = _Pointer.size / 2
	pass # Replace with function body.
