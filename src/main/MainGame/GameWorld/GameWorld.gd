extends Node2D
class_name GameWorld

@onready var _Terrains = %Terrains
@onready var _WorldArea = %WorldArea
@onready var _FogTileMap = %FogTileMap

@export var world_rect := Rect2(Vector2(-1500, -1500), Vector2(3000, 3000))
@export var roots_growth_goal := 100.0
@export var stem_growth_goal := 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	Data.roots_goal = roots_growth_goal
	Data.stem_goal = stem_growth_goal
	for i in _Terrains.get_children():
		i.fog = _FogTileMap
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func init_all():
	for i in Global.get_all_children(_Terrains):
		if i is Terrain:
			i.init_all()
	_WorldArea.init_all()
