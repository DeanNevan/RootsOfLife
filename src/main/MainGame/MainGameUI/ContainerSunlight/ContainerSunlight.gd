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


func _on_mouse_entered():
	GUI._FloatWindow.activate(
		self, 
		"光照等级", 
		"-无法储存\n-影响光合作用速率\n-你的叶子与日光接触面积越大，光照越强"
	)
	pass # Replace with function body.


func _on_mouse_exited():
	GUI._FloatWindow.inactivate(self)
	pass # Replace with function body.
