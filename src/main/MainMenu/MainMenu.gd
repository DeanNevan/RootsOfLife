extends Control

@onready var _ContainerGameWorldChooseElement = %ContainerGameWorldChooseElement
@onready var _ButtonStartGame = %ButtonStartGame
@onready var _ButtonMaker = %ButtonMaker
@onready var _ButtonExit = %ButtonExit

var selected_element : GameWorldChooseElement

# Called when the node enters the scene tree for the first time.
func _ready():
	_ButtonStartGame.disabled = true
	for i in _ContainerGameWorldChooseElement.get_children():
		var element : GameWorldChooseElement = i
		i.connect("select_requested", _on_element_select_requested)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func change_to_main_game():
	get_tree().change_scene_to_packed(preload("res://src/main/MainGame/MainGame.tscn"))

func _on_element_select_requested(element : GameWorldChooseElement):
	selected_element = element
	Data.scene_game_world = element.scene_game_world
	_ButtonStartGame.disabled = false
	for i in _ContainerGameWorldChooseElement.get_children():
		i.unselect()
	element.select()
	pass

func _on_button_start_game_pressed():
	change_to_main_game()
	pass # Replace with function body.


func _on_button_maker_pressed():
	pass # Replace with function body.


func _on_button_exit_pressed():
	get_tree().quit()
	pass # Replace with function body.
