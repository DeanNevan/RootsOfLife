extends MarginContainer

enum Stage{
	HIGH,
	MEDIUM,
	LOW
}

var PERCENT_RANGE_TO_STAGE := {
	Vector2(0.000, 0.333) : Stage.LOW,
	Vector2(0.333, 0.666) : Stage.MEDIUM,
	Vector2(0.666, 1.000) : Stage.HIGH,
}

var STAGE_TO_COLOR := {
	Stage.HIGH : Color.GREEN,
	Stage.MEDIUM : Color.YELLOW,
	Stage.LOW : Color.RED,
}

@onready var _ContainerN = %ContainerN
@onready var _ContainerK = %ContainerK
@onready var _ContainerP = %ContainerP

@onready var _UnitsN = %UnitsN
@onready var _Unit1N = %Unit1N
@onready var _Unit2N = %Unit2N
@onready var _Unit3N = %Unit3N

@onready var _UnitsP = %UnitsP
@onready var _Unit1P = %Unit1P
@onready var _Unit2P = %Unit2P
@onready var _Unit3P = %Unit3P

@onready var _UnitsK = %UnitsK
@onready var _Unit1K = %Unit1K
@onready var _Unit2K = %Unit2K
@onready var _Unit3K = %Unit3K

# Called when the node enters the scene tree for the first time.
func _ready():
	Data.nutrition_n.connect("data_changed", _on_nutrition_n_data_changed)
	Data.nutrition_k.connect("data_changed", _on_nutrition_k_data_changed)
	Data.nutrition_p.connect("data_changed", _on_nutrition_p_data_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_nutrition_n_data_changed():
	var percent : float = float(Data.nutrition_n.value) / Data.nutrition_n.capacity
	var stage := Stage.LOW
	for i in PERCENT_RANGE_TO_STAGE:
		if i.x < percent and i.y > percent:
			stage = PERCENT_RANGE_TO_STAGE[i]
			break
	_UnitsN.modulate = STAGE_TO_COLOR[stage]
	match stage:
		Stage.LOW:
			_Unit1N.modulate.a = 0
			_Unit2N.modulate.a = 0
			_Unit3N.modulate.a = 1
		Stage.MEDIUM:
			_Unit1N.modulate.a = 0
			_Unit2N.modulate.a = 1
			_Unit3N.modulate.a = 1
		Stage.HIGH:
			_Unit1N.modulate.a = 1
			_Unit2N.modulate.a = 1
			_Unit3N.modulate.a = 1
	pass

func _on_nutrition_k_data_changed():
	var percent : float = float(Data.nutrition_k.value) / Data.nutrition_k.capacity
	var stage := Stage.LOW
	for i in PERCENT_RANGE_TO_STAGE:
		if i.x < percent and i.y > percent:
			stage = PERCENT_RANGE_TO_STAGE[i]
			break
	_UnitsK.modulate = STAGE_TO_COLOR[stage]
	match stage:
		Stage.LOW:
			_Unit1K.modulate.a = 0
			_Unit2K.modulate.a = 0
			_Unit3K.modulate.a = 1
		Stage.MEDIUM:
			_Unit1K.modulate.a = 0
			_Unit2K.modulate.a = 1
			_Unit3K.modulate.a = 1
		Stage.HIGH:
			_Unit1K.modulate.a = 1
			_Unit2K.modulate.a = 1
			_Unit3K.modulate.a = 1
	pass

func _on_nutrition_p_data_changed():
	var percent : float = float(Data.nutrition_p.value) / Data.nutrition_p.capacity
	var stage := Stage.LOW
	for i in PERCENT_RANGE_TO_STAGE:
		if i.x < percent and i.y > percent:
			stage = PERCENT_RANGE_TO_STAGE[i]
			break
	_UnitsP.modulate = STAGE_TO_COLOR[stage]
	match stage:
		Stage.LOW:
			_Unit1P.modulate.a = 0
			_Unit2P.modulate.a = 0
			_Unit3P.modulate.a = 1
		Stage.MEDIUM:
			_Unit1P.modulate.a = 0
			_Unit2P.modulate.a = 1
			_Unit3P.modulate.a = 1
		Stage.HIGH:
			_Unit1P.modulate.a = 1
			_Unit2P.modulate.a = 1
			_Unit3P.modulate.a = 1
	pass


func _on_container_n_mouse_entered():
	GUI._FloatWindow.activate(
		_ContainerN, 
		"氮", 
		"-分为缺少、普通、丰富三级\n-普通：增效光合作用50%%\n-丰富：叶子暂停脱落\n-当前：%s" % Data.nutrition_n.get_level_str()
	)
	pass # Replace with function body.


func _on_container_n_mouse_exited():
	GUI._FloatWindow.inactivate(_ContainerN)
	pass # Replace with function body.


func _on_container_p_mouse_entered():
	GUI._FloatWindow.activate(
		_ContainerP, 
		"磷", 
		"-分为缺少、普通、丰富三级\n-普通：建造能量消耗降低50%%\n-丰富：日常能量消耗降低50%%\n-当前：%s" % Data.nutrition_p.get_level_str()
	)
	pass # Replace with function body.


func _on_container_p_mouse_exited():
	GUI._FloatWindow.inactivate(_ContainerP)
	pass # Replace with function body.


func _on_container_k_mouse_entered():
	GUI._FloatWindow.activate(
		_ContainerK, 
		"钾", 
		"-分为缺少、普通、丰富三级\n-普通：能量储存上限提高50%%\n-丰富：能量储存没有上限\n-当前：%s" % Data.nutrition_k.get_level_str()
	)
	pass # Replace with function body.


func _on_container_k_mouse_exited():
	GUI._FloatWindow.inactivate(_ContainerK)
	pass # Replace with function body.
