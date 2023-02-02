extends Node2D
class_name MainGame

# Called when the node enters the scene tree for the first time.
func _ready():
	GameTime.start()
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("%d:%d" % [GameTime.get_day(), GameTime.get_hour_in_day()])
	pass
