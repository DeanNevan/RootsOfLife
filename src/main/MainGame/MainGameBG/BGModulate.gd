extends CanvasModulate

# 从一天的0h-23h的颜色变化图
@export var gradient : Gradient

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	color = gradient.sample(GameTime.get_percent_in_day())
	pass
