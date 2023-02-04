extends Node2D

@export var gradient : Gradient

var percent_in_period := 0.0

func _ready():
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	var percent : float = GameTime.get_percent_in_day()
	$Light.color = gradient.sample(percent)
	if percent > 0.164 and percent < 0.783:
		show()
		percent_in_period = (percent - 0.164) / (0.783 - 0.164)
		var radian : float = PI+PI * (1 - percent_in_period)
		position = 800 * Vector2.RIGHT.rotated(radian)
	else:
		hide()
	#get_viewport_rect().size
