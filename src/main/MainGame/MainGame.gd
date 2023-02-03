extends Node2D
class_name MainGame

@onready var _World = %World
@onready var _TerrainDirts = %TerrainDirts
@onready var _Terrain = %Terrains

# Called when the node enters the scene tree for the first time.
func _ready():
	GameTime.start()
	Data.init_all()
	
	for i in Global.get_all_children(_Terrain):
		if i is Terrain:
			i.init_all()
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$LayerUI/LabelTest.text = "Day:%d Hour:%d" % [
		GameTime.get_day() + 1,
		GameTime.get_hour_in_day() + 1
	]
	#print("%d:%d" % [GameTime.get_day(), GameTime.get_hour_in_day()])
	pass
