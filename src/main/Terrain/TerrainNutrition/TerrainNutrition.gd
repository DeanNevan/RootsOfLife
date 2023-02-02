extends Terrain
class_name TerrainNutrition

@onready var _LabelName = %LabelName

# Called when the node enters the scene tree for the first time.
func _ready():
	enable_texture = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_all():
	super.init_all()
	init_label_name()

func init_label_name():
	pass
