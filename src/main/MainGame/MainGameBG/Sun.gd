extends Node2D

@export var gradient : Gradient

func _ready():
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	var percent : float = GameTime.get_percent_in_day()
	$Light.color = gradient.sample(percent)
	if percent > 0.164 or percent < 0.783:
		show()
		var percent_in_period : float = (percent - 0.164) / (0.783 - 0.164)
		var radian : float = PI+PI * (1 - percent_in_period)
		position = 1000 * Vector2.RIGHT.rotated(radian)
	else:
		hide()
	#get_viewport_rect().size
