extends RigidBody2D

signal seed_ok(pos : Vector2, normal : Vector2)

var is_seeding := false

var areas := []

# Called when the node enters the scene tree for the first time.
func _ready():
	$RayCast2D.add_exception($Area2D)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start():
	is_seeding = true
	gravity_scale = 0

func release() -> bool:
	for i in areas:
		if i is Terrain:
			return false
	is_seeding = false
	gravity_scale = 1
	return true

func _on_area_2d_area_entered(area):
	var object : Object = area
	if area is DetectArea2D:
		object = area.object
	areas.append(object)
	if is_seeding:
		return
	if object is TerrainDirt:
		for i in 8:
			$RayCast2D.target_position = Vector2(0, $Area2D/CollisionShape2D.shape.radius + 2).rotated(i * 2 * PI / 8)
			$RayCast2D.force_raycast_update()
			if $RayCast2D.is_colliding():
				var collider = $RayCast2D.get_collider()
				if collider is DetectArea2D:
					collider = collider.object
				if collider is TerrainDirt:
					emit_signal("seed_ok", $RayCast2D.get_collision_point(), $RayCast2D.get_collision_normal())
					break
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	var object : Object = area
	if area is DetectArea2D:
		object = area.object
	if areas.has(object):
		areas.erase(object)
	pass # Replace with function body.
