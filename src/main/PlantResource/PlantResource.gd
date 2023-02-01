extends Object
class_name PlantResource

signal updated
signal emptied

var value := 0:
	set(_value):
		value = clamp(_value, 0, capacity)
var capacity := 0:
	set(_capacity):
		if _capacity < 0:
			capacity = 0
		else:
			capacity = _capacity
var increase_speed := 0:
	set(_increase_speed):
		if _increase_speed < 0:
			increase_speed = 0
		else:
			increase_speed = _increase_speed
var decrease_speed := 0:
	set(_decrease_speed):
		if _decrease_speed < 0:
			decrease_speed = 0
		else:
			decrease_speed = _decrease_speed

var modifier := Modifier.new(self)

func update():
	value += increase_speed - decrease_speed
	emit_signal("updated")
	if value == 0:
		emit_signal("emptied")
