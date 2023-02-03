extends Node2D
class_name PlantElement

enum Status {
	BUILDING, 
	NORMAL
}
var status : Status = Status.BUILDING

func set_status(_status : Status):
	status = _status
	if status == Status.BUILDING:
		modulate.a = 0.5
	elif status == Status.NORMAL:
		modulate.a = 1

func begin_build():
	set_status(Status.BUILDING)

func finish_build():
	set_status(Status.NORMAL)
