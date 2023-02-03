extends Node2D
class_name MainGame

@export var game_world_node_path : NodePath
@onready var game_world : GameWorld = get_node(game_world_node_path)

# Called when the node enters the scene tree for the first time.
func _ready():
	GameTime.start()
	Data.init_all()
	game_world.init_all()
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("%d:%d" % [GameTime.get_day(), GameTime.get_hour_in_day()])
	pass
