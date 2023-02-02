extends Node2D

var masses = []
var springs = []

# Class for the point mass at each joint
class Mass:
	var mass = 1.0
	var pos = Vector2.ZERO
	var vel = Vector2.ZERO
	var static_point = false

	var GRAVITY = Vector2(0, 9.8)
	var DAMPING = 0.1

	func _init(_pos, _static_point = false):
		pos = _pos
		static_point = _static_point

	func update(force, dt):
		if not static_point:
			vel += (force + GRAVITY) / mass * dt
			vel -= vel * DAMPING * dt
			pos += vel * dt

# Class for the spring connecting the point masses
class Spring:
	var m1 : Mass
	var m2 : Mass
	var rest_length = 1.0
	var rest_angle = 0.0
	
	var K_SPRING = 10.0
	var BENDING_STRENGTH = 100.0

	func _init(_m1, _m2):
		m1 = _m1
		m2 = _m2
		rest_length = (m2.pos - m1.pos).length()
		rest_angle = atan2(m2.pos.y - m1.pos.y, m2.pos.x - m1.pos.x)

	func update(dt):
		var delta = self.m2.pos - self.m1.pos
		var distance = delta.length()
		var direction = delta.normalized()

		var current_angle = atan2(delta.y, delta.x)
		var angle_delta = current_angle - self.rest_angle

		var bending_force = -BENDING_STRENGTH * angle_delta * direction
		var spring_force = direction * K_SPRING * (distance - self.rest_length)

		var force = spring_force + bending_force
		self.m1.update(force, dt)
		self.m2.update(-force, dt)



#func _ready():
#	masses.append(Mass.new(Vector2(500, 100), true))
#	for i in range(1, 10):
#		masses.append(Mass.new(Vector2(500 + i*100, 100)))
#	for i in range(9):
#		springs.append(Spring.new(masses[i], masses[i+1]))
#
#func _process(delta):
#	for i in range(10):
#		for spring in springs:
#			spring.update(delta)
#	self.queue_redraw()
#
#func _draw():
#	for i in range(9):
#		var m1 = masses[i]
#		var m2 = masses[i+1]
#		self.draw_line(m1.pos, m2.pos, Color.PAPAYA_WHIP)
#	for mass in masses:
#		self.draw_circle(mass.pos, 2, Color.PALE_GREEN)
