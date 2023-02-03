extends RigidBody2D

signal seed_ok(pos : Vector2, normal : Vector2)

# Called when the node enters the scene tree for the first time.
func _ready():
	$RayCast2D.add_exception($Area2D)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start():
	gravity_scale = 0
	$Area2D.monitoring = false

func release():
	gravity_scale = 1
	$Area2D.monitoring = true

func _on_area_2d_area_entered(area):
	var object : Object = area
	if area is DetectArea2D:
		object = area.object
	if object is TerrainDirt:
		for i in 8:
			$RayCast2D.target_position = Vector2(0, 100).rotated(i * 2 * PI / 8)
			$RayCast2D.force_raycast_update()
			if $RayCast2D.is_colliding():
				var collider = $RayCast2D.get_collider()
				if collider is DetectArea2D:
					collider = collider.object
				if collider is TerrainDirt:
					emit_signal("seed_ok", $RayCast2D.get_collision_point(), $RayCast2D.get_collision_normal())
					break
	pass # Replace with function body.
