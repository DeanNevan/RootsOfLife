extends Node2D
class_name MainGame

var game_world : GameWorld
@onready var _MainCamera : Camera2D = %MainCamera
@onready var _Seed = %Seed
@onready var _Plant = %Plant
@onready var _LabelSeed = %LabelSeed
@onready var _LabelSeedRE = %LabelSeedRE

var fog_tile_map

var is_seeding := false
var is_seed_ok := false

# Called when the node enters the scene tree for the first time.
func _ready():
	game_world = Data.scene_game_world.instantiate()
	Data.game_world = game_world
	$GameWorld.add_child(game_world)
	fog_tile_map = game_world._FogTileMap
	game_world.remove_child(fog_tile_map)
	$MainGameFog.add_child(fog_tile_map)
	Data.fog = fog_tile_map
	_Plant.fog = fog_tile_map
	$MainGameFog.tilemap = fog_tile_map
	$MainGameFog.init_all()
	
	GameTime.start()
	Data.init_all()
	game_world.init_all()
	start_seed()
	await get_tree().process_frame
	var rect : Rect2 = Data.game_world.world_rect
	_MainCamera.limit_left = rect.position.x
	_MainCamera.limit_right = rect.end.x
	_MainCamera.limit_top = rect.position.y
	_MainCamera.limit_bottom = rect.end.y
	pass # Replace with function body.

func _unhandled_input(event):
	if !is_seed_ok:
		if event is InputEventKey:
			if event.keycode == KEY_SPACE:
				if !event.pressed and is_seeding:
					release_seed()
				elif !event.pressed and !is_seeding:
					start_seed()

# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
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
	_Seed.rotation = 0
	_Seed.linear_velocity = Vector2()
	_Seed.angular_velocity = 0
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


func _on_plant_clear_fog_requested():
	for i in fog_tile_map.get_used_cells(0):
		fog_tile_map.set_cell(0, i, -1)
	pass # Replace with function body.
