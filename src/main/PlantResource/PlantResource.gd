extends Object
class_name PlantResource

signal data_changed
signal updated
signal emptied

var value := 0.0:
	set(_value):
		value = clamp(_value, 0, capacity)
		emit_signal("data_changed")
var capacity := 0.0:
	set(_capacity):
		if _capacity < 0:
			capacity = 0
		else:
			capacity = _capacity
		emit_signal("data_changed")
var increase_speed := 0.0:
	set(_increase_speed):
		if _increase_speed < 0:
			increase_speed = 0
		else:
			increase_speed = _increase_speed
		emit_signal("data_changed")
var decrease_speed := 0.0:
	set(_decrease_speed):
		if _decrease_speed < 0:
			decrease_speed = 0
		else:
			decrease_speed = _decrease_speed
		emit_signal("data_changed")

var modifier := Modifier.new(self)

func update():
	value += get_change_speed()
	emit_signal("updated")
	if value == 0:
		emit_signal("emptied")
	

func get_change_speed() -> float:
	return increase_speed - decrease_speed
