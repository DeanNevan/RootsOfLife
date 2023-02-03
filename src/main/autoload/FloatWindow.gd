extends MarginContainer

@onready var _LabelTitle = %LabelTitle
@onready var _LabelContent = %LabelContent

var is_active := false

var askers := []
var askers_data := {}

var current_asker : Object

# Called when the node enters the scene tree for the first time.
func _ready():
	modulate.a = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_active:
		global_position = get_safe_origin()
	pass

func get_safe_origin() -> Vector2:
	var pos := get_global_mouse_position()
	var sx := size.x
	var sy := size.y
	var viewport_rect := get_viewport_rect()
	var points := []
	var origin := pos
	if Global.is_points_in_rect2(viewport_rect, [Vector2(pos.x + sx, sy), Vector2(pos.x + sx, pos.y + sy), Vector2(pos.x, pos.y + sy)]):
		origin = pos
	elif Global.is_points_in_rect2(viewport_rect, [Vector2(pos.x + sx, sy), Vector2(pos.x + sx, pos.y - sy), Vector2(pos.x, pos.y - sy)]):
		origin = Vector2(pos.x, pos.y - sy)
	elif Global.is_points_in_rect2(viewport_rect, [Vector2(pos.x - sx, sy), Vector2(pos.x - sx, pos.y - sy), Vector2(pos.x, pos.y - sy)]):
		origin = Vector2(pos.x - sx, pos.y - sy)
	else:
		origin = Vector2(pos.x - sx, pos.y)
	return origin

#func update():
#	current_asker = null
#	for i in askers:
#		if i is Terrain
#	pass

func activate(_asker : Object, title := "", content := ""):
	if !askers.has(_asker):
		askers_data[_asker] = [title, content]
		askers.append(_asker)
	is_active = true
	_LabelTitle.text = title
	_LabelContent.text = content
	create_tween().tween_property(self, "modulate:a", 1, 0.5)


func inactivate(_asker : Object):
	if !askers.has(_asker):
		return
	askers.erase(_asker)
	askers_data.erase(_asker)
	if askers.size() > 0:
		_LabelTitle.text = askers_data[askers[0]][0]
		_LabelContent.text = askers_data[askers[0]][1]
		return
	is_active = false
	create_tween().tween_property(self, "modulate:a", 0, 0.25)
	pass
