extends Node

var sunlight := Sunlight.new()
var energy := Energy.new()
var water := Water.new()
var nutrition_n := NutritionN.new()
var nutrition_p := NutritionP.new()
var nutrition_k := NutritionK.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_all():
	sunlight.value = 0
	energy.value = 0
	water.value = 0
	nutrition_n.value = 0
	nutrition_p.value = 0
	nutrition_k.value = 0
	pass
