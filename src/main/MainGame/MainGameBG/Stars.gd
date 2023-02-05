extends Node2D

@export var gradient : Gradient

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().connect("size_changed", _on_viewport_size_changed)
	_on_viewport_size_changed()
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	modulate = gradient.sample(GameTime.get_percent_in_day())
	
	if is_instance_valid(Data.camera):
#		var new_amount = int(100.0 / camera.zoom.x / camera.zoom.y)
#		if new_amount != $ParticlesStar1.amount:
#			$ParticlesStar1.amount = new_amount
		$ParticlesStar1.material.set_shader_parameter("camera_zoom", Data.camera.zoom)

func _on_viewport_size_changed():
	var size : Vector2 = get_viewport_rect().size
	$ParticlesStar1.emission_rect_extents = size / 2
	$ParticlesStar2.emission_rect_extents = size / 2
