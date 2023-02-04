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
@onready var _ButtonExpandGrowthPoint = %ButtonExpandGrowthPoint
@onready var _ContainerGrowthPoint = %ContainerGrowthPoint
@onready var _ProgressBarRootsGrowthPoint = %ProgressBarRootsGrowthPoint
@onready var _LabelRootsGrowthPoint = %LabelRootsGrowthPoint
@onready var _ProgressBarStemGrowthPoint = %ProgressBarStemGrowthPoint
@onready var _LabelStemGrowthPoint = %LabelStemGrowthPoint

var build_type := Global.BuildingType.NONE
var build_size := Global.BuildingSize.NONE

var is_showing_building_menu := false
var is_showing_growth_point := false

# Called when the node enters the scene tree for the first time.
func _ready():
	update_ui()
	Data.connect("roots_growth_point_changed", _on_roots_growth_point_changed)
	Data.connect("stem_growth_point_changed", _on_stem_growth_point_changed)
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_ui():
	update_ui_growth_point()
	update_ui_building_menu()
	_on_roots_growth_point_changed()
	_on_stem_growth_point_changed()

func update_ui_growth_point():
	if is_showing_growth_point:
		_ContainerGrowthPoint.show()
		_ButtonExpandGrowthPoint.icon = preload("res://assets/art/icon/up.png")
	else:
		_ContainerGrowthPoint.hide()
		_ButtonExpandGrowthPoint.icon = preload("res://assets/art/icon/down.png")

func update_ui_building_menu():
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
	update_ui_building_menu()
	pass # Replace with function body.

func _on_button_roots_line_pressed():
	build_type = Global.BuildingType.ROOTS_LINE
	update_ui_building_menu()
	pass # Replace with function body.


func _on_button_storage_roots_pressed():
	build_type = Global.BuildingType.STORAGE_ROOTS
	_ButtonS.button_pressed = false
	_ButtonM.button_pressed = false
	_ButtonL.button_pressed = false
	build_size = Global.BuildingSize.NONE
	update_ui_building_menu()
	pass # Replace with function body.


func _on_button_stem_line_pressed():
	build_type = Global.BuildingType.STEM_LINE
	update_ui_building_menu()
	pass # Replace with function body.


func _on_button_leaf_pressed():
	build_type = Global.BuildingType.LEAF
	_ButtonS.button_pressed = false
	_ButtonM.button_pressed = false
	_ButtonL.button_pressed = false
	build_size = Global.BuildingSize.NONE
	update_ui_building_menu()
	pass # Replace with function body.


func _on_button_s_pressed():
	build_size = Global.BuildingSize.S
	update_ui_building_menu()
	pass # Replace with function body.


func _on_button_m_pressed():
	build_size = Global.BuildingSize.M
	update_ui_building_menu()
	pass # Replace with function body.


func _on_button_l_pressed():
	build_size = Global.BuildingSize.L
	update_ui_building_menu()
	pass # Replace with function body.


func _on_button_expand_growth_point_pressed():
	is_showing_growth_point = !is_showing_growth_point
	update_ui_building_menu()
	pass # Replace with function body.

func _on_roots_growth_point_changed():
	_ProgressBarRootsGrowthPoint.value = _ProgressBarRootsGrowthPoint.max_value * (Data.roots_growth_point / Data.roots_goal)
	_LabelRootsGrowthPoint.text = "%d/%d" % [
		Data.roots_growth_point,
		Data.roots_goal
	]

func _on_stem_growth_point_changed():
	_ProgressBarStemGrowthPoint.value = _ProgressBarStemGrowthPoint.max_value * (Data.stem_growth_point / Data.stem_goal)
	_LabelStemGrowthPoint.text = "%d/%d" % [
		Data.stem_growth_point,
		Data.stem_goal
	]

func _on_container_growth_point_mouse_entered():
	GUI._FloatWindow.activate(
		_ContainerGrowthPoint, 
		"成长值", 
		"-发展你的根系和茎叶可以增加成长值\n-根、茎成长值均满时达成游戏目标"
	)
	pass # Replace with function body.


func _on_container_growth_point_mouse_exited():
	GUI._FloatWindow.inactivate(_ContainerGrowthPoint)
	pass # Replace with function body.


func _on_button_roots_line_mouse_entered():
	GUI._FloatWindow.activate(
		_ButtonRootsLine, 
		"根系", 
		"-用画笔建造根系\n-根必须依附于另一条根，并且沿途不能遇到障碍物\n-每米消耗1能量"
	)
	pass # Replace with function body.


func _on_button_roots_line_mouse_exited():
	GUI._FloatWindow.inactivate(_ButtonRootsLine)
	pass # Replace with function body.


func _on_button_stem_line_mouse_entered():
	GUI._FloatWindow.activate(
		_ButtonStemLine, 
		"茎系", 
		"-用画笔建造茎系\n-茎必须依附于另一条茎，并且沿途不能遇到障碍物\n-每米消耗1能量"
	)
	pass # Replace with function body.


func _on_button_stem_line_mouse_exited():
	GUI._FloatWindow.inactivate(_ButtonStemLine)
	pass # Replace with function body.



func _on_button_storage_roots_mouse_entered():
	GUI._FloatWindow.activate(
		_ButtonStorageRoots, 
		"储藏根", 
		"-用于储存更多的能量\n-必须建造在根系附近\n-按住Q/E来旋转它\n-小：+20能量储存 耗能10\n-中：+40能量储存 耗能20\n-大：+60能量储存 耗能30"
	)
	pass # Replace with function body.


func _on_button_storage_roots_mouse_exited():
	GUI._FloatWindow.inactivate(_ButtonStorageRoots)
	pass # Replace with function body.


func _on_button_leaf_mouse_entered():
	GUI._FloatWindow.activate(
		_ButtonLeaf, 
		"叶子", 
		"-用于接收光照\n-不同尺寸的叶子大小不同\n-必须建造在茎系附近\n-按住Q/E来旋转它\n-小：耗能10\n-中：耗能20\n-大：耗能30"
	)
	pass # Replace with function body.


func _on_button_leaf_mouse_exited():
	GUI._FloatWindow.inactivate(_ButtonLeaf)
	pass # Replace with function body.
