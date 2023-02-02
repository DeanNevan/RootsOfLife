extends HBoxContainer

@onready var _LabelEnergy = %LabelEnergy
@onready var _LabelEnergyCapacity = %LabelEnergyCapacity

# Called when the node enters the scene tree for the first time.
func _ready():
	Data.energy.connect("data_changed", _on_energy_data_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_energy_data_changed():
	var change_speed_str := str(Data.energy.get_change_speed())
	if Data.energy.get_change_speed() >= 0:
		change_speed_str = "+" + change_speed_str
	_LabelEnergy.text = "%d(%s)" % [
		Data.energy.value,
		change_speed_str
	]
	_LabelEnergyCapacity.text = str(Data.energy.capacity)
