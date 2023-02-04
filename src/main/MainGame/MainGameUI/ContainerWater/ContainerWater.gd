extends HBoxContainer

@onready var _LabelWater = %LabelWater
@onready var _LabelWaterCapacity = %LabelWaterCapacity

# Called when the node enters the scene tree for the first time.
func _ready():
	Data.water.connect("data_changed", _on_water_data_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_water_data_changed():
	var change_speed_str := str(Data.water.get_change_speed())
	if Data.water.get_change_speed() >= 0:
		change_speed_str = "+" + change_speed_str
	_LabelWater.text = "%d(%s)" % [
		Data.water.value,
		change_speed_str
	]
	_LabelWaterCapacity.text = str(Data.water.capacity)


func _on_mouse_entered():
	GUI._FloatWindow.activate(
		self, 
		"水分", 
		"-光合作用消耗\n-消耗量等同光照强度\n-你的根系在泥土中越长，水分增长越快\n-注意不同的泥土有不同的水分"
	)
	pass # Replace with function body.


func _on_mouse_exited():
	GUI._FloatWindow.inactivate(self)
	pass # Replace with function body.
