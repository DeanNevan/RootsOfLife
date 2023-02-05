extends Label

@onready var timer := Timer.new()

var tips := [
	"叶片会阻挡阳光，也就是说，你需要好好考虑多个叶片怎么排布",
	
]

var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	add_child(timer)
	timer.one_shot = false
	timer.start(5)
	timer.connect("timeout", _on_timeout)
	pass # Replace with function body.


func _on_timeout():
	text = tips[rng.randi() % tips.size()]
