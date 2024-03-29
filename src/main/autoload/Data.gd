extends Node

signal roots_growth_point_changed
signal stem_growth_point_changed
signal plant_changed
signal growth_point_changed

var sunlight := Sunlight.new()
var energy := Energy.new()
var water := Water.new()
var nutrition_n := NutritionN.new()
var nutrition_p := NutritionP.new()
var nutrition_k := NutritionK.new()

var photosynthesis_effeciency := 1.0
var normal_energy_cost_effeciency := 1.0:
	set(_normal_energy_cost_effeciency):
		normal_energy_cost_effeciency = _normal_energy_cost_effeciency
		emit_signal("growth_point_changed")

var is_pause_leaf_fall := false 
var is_neglect_energy_capacity := false 

#根系成长值(1米=100像素=1成长值，S/M/L储藏根=3/6/9成长值)
var roots_growth_point := 0.0:
	set(_roots_growth_point):
		roots_growth_point = _roots_growth_point
		emit_signal("roots_growth_point_changed")
		emit_signal("growth_point_changed")
#茎系成长值(1米=100像素=1成长值，S/M/L叶子=3/6/9成长值)
var stem_growth_point := 0.0:
	set(_stem_growth_point):
		stem_growth_point = _stem_growth_point
		emit_signal("stem_growth_point_changed")
		emit_signal("growth_point_changed")

var roots_goal := 100.0:
	set(_roots_goal):
		roots_goal = _roots_goal
		emit_signal("roots_growth_point_changed")
var stem_goal := 100.0:
	set(_stem_goal):
		stem_goal = _stem_goal
		emit_signal("stem_growth_point_changed")

var fog

var plant : Plant:
	set(_plant):
		plant = _plant
		if !plant.is_connected("new_roots_line_built", _on_new_roots_line_built):
			plant.connect("new_roots_line_built", _on_new_roots_line_built)
		if !plant.is_connected("new_stem_line_built", _on_new_stem_line_built):
			plant.connect("new_stem_line_built", _on_new_stem_line_built)
		if !plant.is_connected("new_leaf_built", _on_new_leaf_built):
			plant.connect("new_leaf_built", _on_new_leaf_built)
		if !plant.is_connected("new_storage_roots_built", _on_new_storage_roots_built):
			plant.connect("new_storage_roots_built", _on_new_storage_roots_built)
		if !plant.is_connected("leaf_fallen", _on_leaf_fallen):
			plant.connect("leaf_fallen", _on_leaf_fallen)
		emit_signal("plant_changed")

var scene_game_world : PackedScene

var game_world : GameWorld

var camera : Camera2D

var scene_main_game := preload("res://src/main/MainGame/MainGame.tscn")
var scene_main_menu := preload("res://src/main/MainMenu/MainMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	init_all()
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func init_all():
	sunlight.value = 0
	sunlight.capacity = 9999
	energy.capacity = Config.ENERGY_CAPACITY
	energy.value = Config.ENERGY_CAPACITY
	water.capacity = Config.WATER_CAPACITY
	water.value = Config.WATER_CAPACITY
	nutrition_n.capacity = 100
	nutrition_n.value = 0
	nutrition_p.capacity = 100
	nutrition_p.value = 0
	nutrition_k.capacity = 100
	nutrition_k.value = 0
	roots_growth_point = 0.0
	stem_growth_point = 0.0
	is_pause_leaf_fall = false
	pass

func _on_new_roots_line_built(new_line : RootsLine):
	var length : float = new_line.get_length()
	roots_growth_point += length / Config.GROWTH_POINT_ROOTS_LINE_LENGTH
	

func _on_new_stem_line_built(new_line : StemLine):
	var length : float = new_line.get_length()
	stem_growth_point += length / Config.GROWTH_POINT_STEM_LINE_LENGTH

func _on_new_leaf_built(leaf : Leaf):
	if leaf is LeafS:
		stem_growth_point += Config.GROWTH_POINT_LEAF_S
	if leaf is LeafM:
		stem_growth_point += Config.GROWTH_POINT_LEAF_M
	if leaf is LeafL:
		stem_growth_point += Config.GROWTH_POINT_LEAF_L

func _on_new_storage_roots_built(storage_roots : StorageRoots):
	if storage_roots is StorageRootsS:
		roots_growth_point += Config.GROWTH_POINT_STORAGE_ROOTS_S
	if storage_roots is StorageRootsM:
		roots_growth_point += Config.GROWTH_POINT_STORAGE_ROOTS_M
	if storage_roots is StorageRootsL:
		roots_growth_point += Config.GROWTH_POINT_STORAGE_ROOTS_L

func _on_leaf_fallen(leaf : Leaf):
	if leaf is LeafS:
		stem_growth_point -= Config.GROWTH_POINT_LEAF_S
	if leaf is LeafM:
		stem_growth_point -= Config.GROWTH_POINT_LEAF_M
	if leaf is LeafL:
		stem_growth_point -= Config.GROWTH_POINT_LEAF_L
	pass
