extends Control

@onready var _ContainerGameWorldChooseElement = %ContainerGameWorldChooseElement
@onready var _ButtonStartGame = %ButtonStartGame
@onready var _ButtonMaker = %ButtonMaker
@onready var _ButtonExit = %ButtonExit
@onready var _WindowMaker = %WindowMaker

var selected_element : GameWorldChooseElement

# Called when the node enters the scene tree for the first time.
func _ready():
	GUI._FloatWindow.init_all()
	_ButtonStartGame.disabled = true
	for i in _ContainerGameWorldChooseElement.get_children():
		if i is GameWorldChooseElement:
			i.connect("select_requested", _on_element_select_requested)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_to_main_game():
	Global.change_scene_to(self, Data.scene_main_game)

func _on_element_select_requested(element : GameWorldChooseElement):
	selected_element = element
	Data.scene_game_world = element.scene_game_world
	_ButtonStartGame.disabled = false
	for i in _ContainerGameWorldChooseElement.get_children():
		if i is GameWorldChooseElement:
			i.unselect()
	element.select()
	pass

func _on_button_start_game_pressed():
	change_to_main_game()
	pass # Replace with function body.


func _on_button_maker_pressed():
	_WindowMaker.show()
	pass # Replace with function body.


func _on_button_exit_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_button_close_maker_pressed():
	_WindowMaker.hide()
	pass # Replace with function body.
