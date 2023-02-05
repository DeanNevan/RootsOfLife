extends Node2D

var root_scene = preload("res://src/test/line_2d.tscn")

var tree_segments = []
var branch_probability = 0.005

func _ready():
	# Set the initial segment
	tree_segments.append([Vector2(0,0), Vector2(1,1)])

var t = 100

var total = 0

func _process(delta):
	if total > 256:
		return
	t -= 1
	if t < 0:
		t = 100
	else:
		return
	# Generate additional segments
	for i in range(1):
		var new_segments = []
		for segment in tree_segments:
			var endpoint = segment[1]
			new_segments += generate_segments(endpoint)
			
		for j in new_segments:
			var new_root = root_scene.instantiate()
			new_root.points = j
			new_root.get_child(0).points = j
			self.add_child(new_root)
			total += 1
			await RenderingServer.frame_post_draw
			await RenderingServer.frame_post_draw
			await RenderingServer.frame_post_draw
			
		tree_segments += new_segments

func generate_segments(start):
	# Generate new segments
	var new_segments = []
	if randf() < branch_probability:
		var new_segment_1 = generate_segment(start, Vector2(randf_range(-20, 200), randf_range(-20, 200)))
		new_segments.append(new_segment_1)
	var new_segment_2 = generate_segment(start, Vector2(randf_range(-20, 200), randf_range(-20, 200)))
	new_segments.append(new_segment_2)

	# Return the new segments
	return new_segments

func generate_segment(start, offset):
	# Generate a new endpoint with the given offset
	var new_endpoint = start + offset

	# Return the new segment
	return [start, new_endpoint]
