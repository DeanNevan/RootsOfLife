extends Label

@onready var timer := Timer.new()

var index := 0

var tips := [
	"叶片会阻挡阳光，也就是说，你需要好好考虑多个叶片怎么排布",
	"同时拥有三个及以上的某个营养区域是在浪费资源",
	"推荐尽快寻找到两个钾区域，那样可以直接清空迷雾",
	"没时间做翻译！！！所以只有中文了",
	"同一片水域只能提供一次水分加成",
	"沃土是水分最充足的土壤",
	"记得进入游戏后，右上角有帮助按钮",
	"游戏目标是培养植物，权衡消耗和发展，使成长值达标",
]

var rng := RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	add_child(timer)
	timer.one_shot = false
	timer.start(5)
	timer.connect("timeout", _on_timeout)
	_on_timeout()
	pass # Replace with function body.


func _on_timeout():
	#text = tips[index % tips.size()]
	text = tips[rng.randi() % tips.size()]
	index += 1
