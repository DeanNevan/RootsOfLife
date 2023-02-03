extends Node2D
class_name MainGame

@export var game_world_node_path : NodePath
@onready var game_world : GameWorld = get_node(game_world_node_path)
@onready var _MainCamera : Camera2D = %MainCamera
@onready var _Seed = %Seed
@onready var _Plant = %Plant
@onready var _LabelSeed = %LabelSeed
@onready var _LabelSeedRE = %LabelSeedRE

var is_seeding := false
var is_seed_ok := false

# Called when the node enters the scene tree for the first time.
func _ready():
	GameTime.start()
	Data.init_all()
	game_world.init_all()
	start_seed()
	pass # Replace with function body.

func _unhandled_input(event):
	if !is_seed_ok:
		if event is InputEventKey:
			if event.keycode == KEY_SPACE:
				if !event.pressed and is_seeding:
					release_seed()
				elif !event.pressed and !is_seeding:
					start_seed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_seeding:
		_Seed.global_position = get_global_mouse_position()
#	var screen_coord := Global.convert_target_position2(
#		$MainGameBG.get_viewport_transform(), 
#		$MainGameBG.global_transform, 
#		Vector2()
#	)
#	$MainGameBG.position = screen_coord
#	print(screen_coord)
	pass

func start_seed():
	_Seed.start()
	is_seeding = true
	_LabelSeed.show()
	_LabelSeedRE.hide()
	pass

func release_seed():
	if (_Seed.release()):
		is_seeding = false
		_LabelSeed.hide()
		_LabelSeedRE.show()
	pass


func _on_seed_seed_ok(pos, normal):
	is_seed_ok = true
	is_seeding = false
	_LabelSeed.hide()
	_LabelSeedRE.hide()
	_Seed.hide()
	_Plant.seed_ok(pos, normal)
	pass # Replace with function body.


func _on_main_game_ui_building_requested(build_type, build_size):
	if is_instance_valid(_Plant):
		_Plant.build_type = build_type
		_Plant.build_size = build_size
		_Plant.start_building()
	pass # Replace with function body.


func _on_main_game_ui_building_canceled():
	if is_instance_valid(_Plant):
		_Plant.build_type = Global.BuildingType.NONE
		_Plant.build_size = Global.BuildingSize.NONE
		_Plant.stop_building()
	pass # Replace with function body.


