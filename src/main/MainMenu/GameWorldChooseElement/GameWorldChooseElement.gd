extends MarginContainer
class_name GameWorldChooseElement

signal select_requested(element)

@onready var _CheckBox = %CheckBox

@export var scene_game_world : PackedScene
@export var texture := preload("res://icon.svg")
@export var hint_title := "标题"
@export_multiline var hint_content := "内容"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Button.icon = texture
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func select():
	_CheckBox.button_pressed = true

func unselect():
	_CheckBox.button_pressed = false

func _on_button_pressed():
	emit_signal("select_requested", self)
	pass # Replace with function body.



func _on_button_mouse_entered():
	GUI._FloatWindow.activate(
		self, 
		hint_title,
		hint_content
	)
	pass # Replace with function body.


func _on_button_mouse_exited():
	GUI._FloatWindow.inactivate(self)
	pass # Replace with function body.
