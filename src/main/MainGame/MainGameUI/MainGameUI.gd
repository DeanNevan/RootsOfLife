extends Control

signal building_canceled
signal building_requested(build_type : Global.BuildingType, build_size : Global.BuildingSize)

@onready var _ButtonRootsLine = %ButtonRootsLine
@onready var _ButtonStorageRoots = %ButtonStorageRoots
@onready var _ButtonStemLine = %ButtonStemLine
@onready var _ButtonLeaf = %ButtonLeaf
@onready var _ButtonS = %ButtonS
@onready var _ButtonM = %ButtonM
@onready var _ButtonL = %ButtonL
@onready var _ContainerBuildingSize = %ContainerBuildingSize
@onready var _ContainerBuildingType = %ContainerBuildingType
@onready var _ButtonExpandBuildingMenu = %ButtonExpandBuildingMenu

var build_type := Global.BuildingType.NONE
var build_size := Global.BuildingSize.NONE

var is_showing_building_menu := false

# Called when the node enters the scene tree for the first time.
func _ready():
	update_ui()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_ui():
	emit_signal("building_canceled")
	if !is_showing_building_menu:
		_ButtonExpandBuildingMenu.icon = preload("res://assets/art/icon/up.png")
		_ButtonRootsLine.button_pressed = false
		_ButtonStorageRoots.button_pressed = false
		_ButtonStemLine.button_pressed = false
		_ButtonLeaf.button_pressed = false
		_ButtonS.button_pressed = false
		_ButtonM.button_pressed = false
		_ButtonL.button_pressed = false
		_ContainerBuildingType.hide()
		_ContainerBuildingSize.hide()
	else:
		_ContainerBuildingType.show()
		_ButtonExpandBuildingMenu.icon = preload("res://assets/art/icon/down.png")
		if build_type == Global.BuildingType.ROOTS_LINE or build_type == Global.BuildingType.STEM_LINE:
			_ContainerBuildingSize.hide()
		elif build_type == Global.BuildingType.STORAGE_ROOTS or build_type == Global.BuildingType.LEAF:
			_ContainerBuildingSize.show()
		else:
			_ContainerBuildingSize.hide()
		if !_ContainerBuildingSize.visible:
			_ButtonS.button_pressed = false
			_ButtonM.button_pressed = false
			_ButtonL.button_pressed = false
		
		
		if build_type == Global.BuildingType.ROOTS_LINE or build_type == Global.BuildingType.STEM_LINE:
			emit_signal("building_requested", build_type, build_size)
		elif build_type == Global.BuildingType.STORAGE_ROOTS and build_size != Global.BuildingSize.NONE:
			emit_signal("building_requested", build_type, build_size)
		elif build_type == Global.BuildingType.LEAF and build_size != Global.BuildingSize.NONE:
			emit_signal("building_requested", build_type, build_size)
		
	pass


func _on_button_expand_building_menu_pressed():
	is_showing_building_menu = !is_showing_building_menu
	if !is_showing_building_menu:
		build_type = Global.BuildingType.NONE
		build_size = Global.BuildingSize.NONE
		emit_signal("building_canceled")
	update_ui()
	pass # Replace with function body.

func _on_button_roots_line_pressed():
	build_type = Global.BuildingType.ROOTS_LINE
	update_ui()
	pass # Replace with function body.


func _on_button_storage_roots_pressed():
	build_type = Global.BuildingType.STORAGE_ROOTS
	_ButtonS.button_pressed = false
	_ButtonM.button_pressed = false
	_ButtonL.button_pressed = false
	build_size = Global.BuildingSize.NONE
	update_ui()
	pass # Replace with function body.


func _on_button_stem_line_pressed():
	build_type = Global.BuildingType.STEM_LINE
	update_ui()
	pass # Replace with function body.


func _on_button_leaf_pressed():
	build_type = Global.BuildingType.LEAF
	_ButtonS.button_pressed = false
	_ButtonM.button_pressed = false
	_ButtonL.button_pressed = false
	build_size = Global.BuildingSize.NONE
	update_ui()
	pass # Replace with function body.


func _on_button_s_pressed():
	build_size = Global.BuildingSize.S
	update_ui()
	pass # Replace with function body.


func _on_button_m_pressed():
	build_size = Global.BuildingSize.M
	update_ui()
	pass # Replace with function body.


func _on_button_l_pressed():
	build_size = Global.BuildingSize.L
	update_ui()
	pass # Replace with function body.
