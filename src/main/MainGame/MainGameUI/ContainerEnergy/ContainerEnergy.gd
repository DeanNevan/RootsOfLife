extends HBoxContainer

@onready var _LabelEnergy = %LabelEnergy
@onready var _LabelEnergyCapacity = %LabelEnergyCapacity

# Called when the node enters the scene tree for the first time.
func _ready():
	Data.energy.connect("data_changed", _on_energy_data_changed)
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_energy_data_changed():
	var change_speed_str := str(Data.energy.get_change_speed()).pad_decimals(1)
	if Data.energy.get_change_speed() >= 0:
		change_speed_str = "+" + change_speed_str
	_LabelEnergy.text = "%d(%s)" % [
		Data.energy.value,
		change_speed_str
	]
	_LabelEnergyCapacity.text = str(Data.energy.capacity)


func _on_mouse_entered():
	GUI._FloatWindow.activate(
		self, 
		"能量", 
		"-即碳水化合物\n-由光合作用产生，消耗1单位水分，产生%.1f单位能量\n-建造储藏根来增加最大容量\n-植物成长值越大，日常消耗越大，当前消耗:%.3f" % [
			Config.PHOTOSYNTHESIS_RATE,
			Data.energy.decrease_speed
		]
	)
	pass # Replace with function body.


func _on_mouse_exited():
	GUI._FloatWindow.inactivate(self)
	pass # Replace with function body.
