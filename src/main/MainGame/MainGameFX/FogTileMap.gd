extends TileMap

@onready var particle_scene = preload("res://src/main/MainGame/MainGameFX/FogParticle.tscn")
#@onready var particle = $FogParticle

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func defog(points):
	for i in range(points.size() - 1):
		var point_a = points[i]
		var point_b = points[i+1]
		var xtiles = intersect_segment_with_tilemap(point_a, point_b)
		for tile in xtiles:
			dig(0, tile + Vector2i(0,0), -1)
			dig(0, tile + Vector2i(1,0), -1)
			dig(0, tile + Vector2i(0,1), -1)
			dig(0, tile + Vector2i(-1,0), -1)
			dig(0, tile + Vector2i(0,-1), -1)

func dig(_layer, pos, _id):
	if self.get_cell_source_id(_layer, pos) != -1:
		var particle = particle_scene.instantiate()
		particle.position = pos * 64.0
#		particle..connect
		particle.emitting = true
		self.add_child(particle)
		self.set_cell(_layer, pos, _id)

func intersect_segment_with_tilemap(segment_start, segment_end):
	var rect = self.get_used_rect()
	var tile_start = self.local_to_map(segment_start)
	var tile_end = self.local_to_map(segment_end)
	
	var delta = Vector2(tile_end - tile_start)
	
	if delta.length() == 0:
		return [tile_start]
	
	delta = delta.normalized()
	
	var steps = (tile_end - tile_start).length()
	
	var intersected_tiles = []
	
	for i in range(int(steps) + 1):
		var tile = Vector2(tile_start) + delta * i
		tile = Vector2i(tile)
		
		if rect.has_point(tile):
			intersected_tiles.append(tile)
	
	return intersected_tiles
