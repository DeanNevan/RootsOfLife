extends Node

signal hour_passed
signal day_passed

var timestamp := 0

var day := 0
var hour := 0

func _physics_process(_delta):
	timestamp += 1
	var _day = get_day()
	var _hour = get_hour_in_day()
	if _day != day:
		emit_signal("day_passed")
	if _hour != hour:
		emit_signal("hour_passed")
	day = _day
	hour = _hour

func reset():
	timestamp = 0

func stop():
	set_physics_process(false)

func start():
	set_physics_process(true)

func get_day() -> int:
	return timestamp / (24 * Config.STAMP_PER_HOUR)

func get_hour_in_day() -> int:
	return (timestamp - (get_day() * 24 * Config.STAMP_PER_HOUR)) / Config.STAMP_PER_HOUR

func get_percent_in_day() -> float:
	return (timestamp - (get_day() * 24 * Config.STAMP_PER_HOUR)) / (Config.STAMP_PER_HOUR * 24.0)
