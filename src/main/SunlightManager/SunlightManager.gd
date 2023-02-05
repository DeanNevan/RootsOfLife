extends Node2D

var distance_period := 10
var ray_cast_count := 0

var percent := 0.0
var is_enabled := true

var frame_count := 0
var update_period_frame := 30

var sunlight_level_per_raycast := 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	$RayCasts.rotation_degrees = percent * -180
	frame_count += 1
	if frame_count % update_period_frame == 0:
		update_sunlight_level()
	pass

func update_sunlight_level():
	if !is_enabled:
		return
	var sunlight_level := 0.0
	for i in $RayCasts.get_children():
		var ray_cast : RayCast2D = i
		if ray_cast.is_colliding:
			var collider : Object = ray_cast.get_collider()
			if is_instance_valid(collider):
				var object : Object = collider
				if collider is DetectArea2D:
					object = collider.object
				if object is Terrain:
					continue
				elif object is Leaf:
					if object.status == Leaf.Status.NORMAL:
						sunlight_level += sunlight_level_per_raycast
				else:
					ray_cast.add_exception(collider)
	Data.sunlight.value = sunlight_level
	pass

func init_all():
	var rect : Rect2 = Data.game_world.world_rect
	for i in $RayCasts.get_children():
		i.queue_free()
	ray_cast_count = 0
	var y : int = rect.end.y + 100
	while y >= rect.position.y:
		var ray_cast := RayCast2D.new()
		$RayCasts.add_child(ray_cast)
		ray_cast.collide_with_areas = true
		ray_cast.collide_with_bodies = false
		ray_cast.position = Vector2(rect.end.x + 100, y)
		ray_cast.target_position = Vector2(-rect.size.x - 200, 0)
		#ray_cast.target_position = Vector2(-rect.size.x / 2, 0)
		y -= distance_period
		ray_cast_count += 1
		if ray_cast_count % 50 == 0:
			await get_tree().process_frame
	pass
