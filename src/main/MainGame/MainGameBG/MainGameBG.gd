extends Node2D
class_name MainGameBG

var viewport_size 

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	$SunlightManager.init_all()
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.

func _process(_delta):
	if is_instance_valid(Data.camera):
		global_position = Data.camera.global_position
		scale.x = 1 / Data.camera.zoom.x
		scale.y = 1 / Data.camera.zoom.y
	
	if $Sun.visible:
		$SunlightManager.sunlight_level_per_raycast = Config.SUNLIGHT_LEVEL_SUN_PER_RAYCAST
		$SunlightManager.percent = $Sun.percent_in_period
		pass
	elif $Moon.visible:
		$SunlightManager.sunlight_level_per_raycast = Config.SUNLIGHT_LEVEL_MOON_PER_RAYCAST
		$SunlightManager.percent = $Moon.percent_in_period
		pass
	

