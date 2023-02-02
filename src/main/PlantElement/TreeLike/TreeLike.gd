extends PlantElement
class_name TreeLike

@onready var _Origin = %Origin
@onready var _TreeLikeLines = %TreeLikeLines

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_origin() -> Marker2D:
	return _Origin

func add_line(line : TreeLikeLine):
	_TreeLikeLines.add_child(line)
