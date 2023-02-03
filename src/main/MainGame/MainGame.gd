extends Node2D
class_name MainGame

@export var game_world_node_path : NodePath
@onready var game_world : GameWorld = get_node(game_world_node_path)
@onready var _MainCamera : Camera2D = %MainCamera

# Called when the node enters the scene tree for the first time.
func _ready():
	GameTime.start()
	Data.init_all()
	game_world.init_all()
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	var screen_coord := Global.convert_target_position2(
#		$MainGameBG.get_viewport_transform(), 
#		$MainGameBG.global_transform, 
#		Vector2()
#	)
#	$MainGameBG.position = screen_coord
#	print(screen_coord)
	pass
