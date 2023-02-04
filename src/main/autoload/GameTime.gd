extends Node

enum Period{
	
}

var STAMP_PER_HOUR := 20 # 60物理帧=1秒/一小时

var timestamp := 0

func _physics_process(_delta):
	timestamp += 1

func reset():
	timestamp = 0

func stop():
	set_physics_process(false)

func start():
	set_physics_process(true)

func get_day() -> int:
	return timestamp / (24 * STAMP_PER_HOUR)

func get_hour_in_day() -> int:
	return (timestamp - (get_day() * 24 * STAMP_PER_HOUR)) / STAMP_PER_HOUR

func get_percent_in_day() -> float:
	return (timestamp - (get_day() * 24 * STAMP_PER_HOUR)) / (STAMP_PER_HOUR * 24.0)
