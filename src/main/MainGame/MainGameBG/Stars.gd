extends Node2D

@export var gradient : Gradient

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().connect("size_changed", _on_viewport_size_changed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	modulate = gradient.sample(GameTime.get_percent_in_day())

func _on_viewport_size_changed():
	var size : Vector2 = get_viewport_rect().size
	$ParticlesStar1.emission_rect_extents = size / 2
	$ParticlesStar1.position = size / 2
	$ParticlesStar2.emission_rect_extents = size / 2
	$ParticlesStar2.position = size / 2
