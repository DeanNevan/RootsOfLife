extends HBoxContainer

@onready var _LabelSunlight = %LabelSunlight

# Called when the node enters the scene tree for the first time.
func _ready():
	Data.sunlight.connect("data_changed", _on_sunlight_data_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_sunlight_data_changed():
	_LabelSunlight.text = str(Data.sunlight.value)
