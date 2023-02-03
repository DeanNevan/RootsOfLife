extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "%d天 %d时" % [
		GameTime.get_day() + 1,
		GameTime.get_hour_in_day() + 1
	]
	pass
