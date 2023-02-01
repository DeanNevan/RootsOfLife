extends Node2D

var value := 0:
	set(_value):
		print(_value)
		value = _value

# Called when the node enters the scene tree for the first time.
func _ready():
	value += 3
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
