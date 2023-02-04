extends Node2D
class_name GameWorld

@onready var _Terrains = %Terrains
@onready var _WorldArea = %WorldArea

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func init_all():
	for i in Global.get_all_children(_Terrains):
		if i is Terrain:
			i.init_all()
	_WorldArea.init_all()
