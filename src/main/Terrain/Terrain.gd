extends Polygon2D
class_name Terrain

var enable_texture := true:
	set(_enable_texture):
		enable_texture = _enable_texture
		if enable_texture:
			self_modulate.a = 1
		else:
			self_modulate.a = 0

@onready var _AreaTerrain = %AreaTerrain
@onready var _PolygonTexture = %PolygonTexture
@onready var _LineBorder = %LineBorder
@onready var _Label = %Label
@onready var _LightOccluder = %LightOccluder

@export var border_color := Color(1, 1, 1, 0)
@export var texture_color_override := false

var hint_title := "区域"
var hint_content := "NULL"

# Called when the node enters the scene tree for the first time.
func _ready():
	enable_texture = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_all():
	self_modulate.a = 0
	polygon = Global.get_optimized_points(polygon)
	assert(polygon.size() >= 2)
	var offset_polygon := PackedVector2Array()
	for i in polygon.size():
		var pos : Vector2 = polygon[i]
		pos.x *= scale.x
		pos.y *= scale.y
		pos += global_position
		offset_polygon.append(pos)
	polygon = offset_polygon
	global_position = Vector2()
	global_scale = Vector2.ONE
	init_area_terrain()
	init_line_border()
	init_polygon_texture()
	init_label()
	init_light_occluder()

func init_light_occluder():
	_LightOccluder.occluder.polygon = polygon

func init_label():
	_Label.position = Global.get_center_position_in_polygon(polygon)
	pass

func init_area_terrain():
	for i in _AreaTerrain.get_children():
		i.queue_free()
	var collision_shape := CollisionPolygon2D.new()
	collision_shape.polygon = polygon
	_AreaTerrain.add_child(collision_shape)

func init_line_border():
	_LineBorder.default_color = border_color
	_LineBorder.points = polygon
	if _LineBorder.points.size() != 0:
		_LineBorder.add_point(_LineBorder.points[0])

func init_polygon_texture():
	_PolygonTexture.polygon = polygon
	if texture_color_override:
		_PolygonTexture.color = color

func _on_area_terrain_mouse_entered():
	GUI._FloatWindow.activate(self, hint_title, hint_content)


func _on_area_terrain_mouse_exited():
	GUI._FloatWindow.inactivate(self)
