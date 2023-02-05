extends Node2D
class_name Plant

signal new_roots_line_built(roots_line)
signal new_stem_line_built(stem_line)
signal new_leaf_built(leaf)
signal new_storage_roots_built(storage_roots)
signal clear_fog_requested
signal leaf_fallen(leaf)

@onready var _Roots = %Roots
@onready var _Stem = %Stem
@onready var _Leaves = %Leaves
@onready var _StorageRoots = %StorageRoots
@onready var _AreaMouseDrawer = %AreaMouseDrawer
@onready var _TimerDrawing = %TimerDrawing
@onready var _RayDrawing = %RayDrawing
@onready var _SpriteMouseDrawer = %SpriteMouseDrawer

var fog

var scene_roots_line : PackedScene = preload("res://src/main/TreeLike/Roots/RootsLine.tscn")
var scene_stem_line : PackedScene = preload("res://src/main/TreeLike/Stem/StemLine.tscn")
var scene_leaf_s : PackedScene = preload("res://src/main/PlantElement/Leaf/LeafS/LeafS.tscn")
var scene_leaf_m : PackedScene = preload("res://src/main/PlantElement/Leaf/LeafM/LeafM.tscn")
var scene_leaf_l : PackedScene = preload("res://src/main/PlantElement/Leaf/LeafL/LeafL.tscn")
var scene_storage_roots_s : PackedScene = preload("res://src/main/PlantElement/StorageRoots/StorageRootsS/StorageRootsS.tscn")
var scene_storage_roots_m : PackedScene = preload("res://src/main/PlantElement/StorageRoots/StorageRootsM/StorageRootsM.tscn")
var scene_storage_roots_l : PackedScene = preload("res://src/main/PlantElement/StorageRoots/StorageRootsL/StorageRootsL.tscn")

var build_type := Global.BuildingType.NONE
var build_size := Global.BuildingSize.NONE
var is_building := false

var drawing_line_parent : TreeLikeLine
var drawing_line : TreeLikeLine
var is_drawing := false
var drawing_safe_position := Vector2()
var is_drawing_meet_collision := false
var drawing_unsafe_objects := []
var objects_in_mouse_area := []
var tree_like_lines_shapes := {}

var is_building_plant_element := false
var building_plant_element : PlantElement

var normal_energy_cost := 0.0

var is_nutrition_k_working := false

# Called when the node enters the scene tree for the first time.
func _ready():
	stop_building()
	Data.plant = self
	GameTime.connect("hour_passed", _on_hour_passed)
	Data.connect("growth_point_changed", _on_growth_point_changed)
	pass # Replace with function body.

func _unhandled_input(event):
	if is_building:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					if build_type == Global.BuildingType.ROOTS_LINE or build_type == Global.BuildingType.STEM_LINE:
						request_start_draw_treelike_line()
				else:
					if build_type == Global.BuildingType.ROOTS_LINE or build_type == Global.BuildingType.STEM_LINE:
						request_stop_draw_treelike_line()
					if build_type == Global.BuildingType.LEAF:
						if is_instance_valid(building_plant_element):
							var result : bool = building_plant_element.can_build()
							if result:
								if Data.energy.try_consume(building_plant_element.energy_cost):
									building_plant_element.finish_build()
									emit_signal("new_leaf_built", building_plant_element)
									building_plant_element.connect("fall_requested", _on_leaf_fall_requested)
									building_plant_element = null
									request_building_leaf()
								else:
									alert_cost_fail()
					if build_type == Global.BuildingType.STORAGE_ROOTS:
						if is_instance_valid(building_plant_element):
							var result : bool = building_plant_element.can_build()
							if result:
								if Data.energy.try_consume(building_plant_element.energy_cost):
									building_plant_element.finish_build()
									emit_signal("new_storage_roots_built", building_plant_element)
									building_plant_element = null
									request_building_storage_roots()
								else:
									alert_cost_fail()

# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# Called every frame. '_delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	_AreaMouseDrawer.global_position = get_global_mouse_position()
	if is_building_plant_element:
		if is_instance_valid(building_plant_element):
			building_plant_element.global_position = get_global_mouse_position()

func request_building_leaf():
	if is_instance_valid(building_plant_element):
		building_plant_element.queue_free()
	if build_size == Global.BuildingSize.S:
		building_plant_element = scene_leaf_s.instantiate()
	if build_size == Global.BuildingSize.M:
		building_plant_element = scene_leaf_m.instantiate()
	if build_size == Global.BuildingSize.L:
		building_plant_element = scene_leaf_l.instantiate()
	if is_instance_valid(building_plant_element):
		_Leaves.add_child(building_plant_element)
		is_building_plant_element = true
		building_plant_element.begin_build()

func request_building_storage_roots():
	if is_instance_valid(building_plant_element):
		building_plant_element.queue_free()
	if build_size == Global.BuildingSize.S:
		building_plant_element = scene_storage_roots_s.instantiate()
	if build_size == Global.BuildingSize.M:
		building_plant_element = scene_storage_roots_m.instantiate()
	if build_size == Global.BuildingSize.L:
		building_plant_element = scene_storage_roots_l.instantiate()
	if is_instance_valid(building_plant_element):
		_Leaves.add_child(building_plant_element)
		is_building_plant_element = true
		building_plant_element.begin_build()

func start_building():
	is_building = true
	if build_type == Global.BuildingType.ROOTS_LINE or build_type == Global.BuildingType.STEM_LINE:
		_SpriteMouseDrawer.modulate = Color.SADDLE_BROWN if build_type == Global.BuildingType.ROOTS_LINE else Color.GREEN
		_AreaMouseDrawer.show()
	else:
		if build_type == Global.BuildingType.LEAF:
			request_building_leaf()
		if build_type == Global.BuildingType.STORAGE_ROOTS:
			request_building_storage_roots()
		_AreaMouseDrawer.hide()
	pass

func stop_building():
	is_building = false
	_AreaMouseDrawer.hide()
	is_building_plant_element = true
	if is_instance_valid(building_plant_element):
		building_plant_element.queue_free()
	pass

func request_start_draw_treelike_line():
	var closet_distance : float = 999
	var split_point_a : Vector2
	var split_point_b : Vector2
	var closet_point := Vector2()
	drawing_line_parent = null
	for i in tree_like_lines_shapes.keys():
		if !is_instance_valid(i):
			tree_like_lines_shapes.erase(i)
		elif (i is RootsLine and build_type == Global.BuildingType.ROOTS_LINE) or (i is StemLine and build_type == Global.BuildingType.STEM_LINE):
			for j in tree_like_lines_shapes[i]:
				if !is_instance_valid(j):
					continue
				var segment_shape : SegmentShape2D = j.shape
				var _point : Vector2 = Geometry2D.get_closest_point_to_segment(
					get_global_mouse_position(),
					segment_shape.a,
					segment_shape.b
				)
				var distance : float = (_point - get_global_mouse_position()).length()
				if distance < closet_distance:
					split_point_a = segment_shape.a
					split_point_b = segment_shape.b
					drawing_line_parent = i
					closet_point = _point
	if !is_instance_valid(drawing_line_parent):
		return
	
	
	var line_ab
	if build_type == Global.BuildingType.ROOTS_LINE:
		drawing_line = scene_roots_line.instantiate()
		line_ab = _Roots.split_line(drawing_line_parent, closet_point, split_point_a, split_point_b)
	elif build_type == Global.BuildingType.STEM_LINE:
		drawing_line = scene_stem_line.instantiate()
		line_ab = _Stem.split_line(drawing_line_parent, closet_point, split_point_a, split_point_b)
	else:
		return
	
	drawing_line_parent = line_ab[0] #line_a
	is_drawing = true
	drawing_line.parent_line = drawing_line_parent
	drawing_line.fog = fog
	
	if build_type == Global.BuildingType.ROOTS_LINE:
		_Roots.add_line(drawing_line)
	elif build_type == Global.BuildingType.STEM_LINE:
		_Stem.add_line(drawing_line)
	drawing_line.begin_build()
	drawing_line.build_new_point(closet_point, false)
	drawing_safe_position = closet_point
	_TimerDrawing.start()
	_AreaMouseDrawer.get_node("CollisionShape2D").shape.radius = 5
	pass

func request_stop_draw_treelike_line():
	if !is_drawing:
		return
	_AreaMouseDrawer.get_node("CollisionShape2D").shape.radius = 10
	is_drawing = false
	if is_instance_valid(drawing_line):
		if !is_instance_valid(drawing_line_parent):
			drawing_line.queue_free()
			return
		drawing_line.finish_build()
		drawing_line_parent.register_child_line(drawing_line)
		if drawing_line is RootsLine:
			emit_signal("new_roots_line_built", drawing_line)
		if drawing_line is StemLine:
			emit_signal("new_stem_line_built", drawing_line)
	drawing_line = null
	drawing_line_parent = null
	pass

func seed_ok(pos : Vector2, normal : Vector2):
	var roots_line : RootsLine = scene_roots_line.instantiate()
	_Roots.add_line(roots_line)
	var stem_line : StemLine = scene_stem_line.instantiate()
	_Stem.add_line(stem_line)
	roots_line.fog = fog
	stem_line.fog = fog
	
	roots_line.begin_build()
	stem_line.begin_build()
	
	roots_line.build_new_point(pos, false)
	roots_line.build_new_point(pos - normal * 10, false)
	
	stem_line.build_new_point(pos, false)
	stem_line.build_new_point(pos + normal * 10, false)
	
	roots_line.finish_build()
	stem_line.finish_build()
	
	emit_signal("new_roots_line_built", roots_line)
	emit_signal("new_stem_line_built", stem_line)
	
	pass

func alert_cost_fail():
	pass

func _on_area_mouse_drawer_area_entered(area):
	var object = area
	if area is DetectArea2D:
		object = area.object
	objects_in_mouse_area.append(area)
	if object is TerrainBarrier or object is TreeLikeLine:
		drawing_unsafe_objects.append(object)
		is_drawing_meet_collision = true
	pass # Replace with function body.


func _on_area_mouse_drawer_area_exited(area):
	var object = area
	if area is DetectArea2D:
		object = area.object
	objects_in_mouse_area.erase(area)
	if drawing_unsafe_objects.has(object):
		drawing_unsafe_objects.erase(object)
		if drawing_unsafe_objects.size() == 0:
			is_drawing_meet_collision = false
	pass # Replace with function body.


func _on_area_mouse_drawer_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area is DetectArea2D:
		if area.object is TreeLikeLine:
			if tree_like_lines_shapes.get(area.object) == null:
				tree_like_lines_shapes[area.object] = []
			tree_like_lines_shapes[area.object].append(area.get_child(area_shape_index))
	pass # Replace with function body.


func _on_area_mouse_drawer_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if area is DetectArea2D:
		if area.object is TreeLikeLine:
			if tree_like_lines_shapes.get(area.object) != null:
				tree_like_lines_shapes[area.object].erase(area.get_child(area_shape_index))
			if tree_like_lines_shapes[area.object].size() == 0:
				tree_like_lines_shapes.erase(area.object)
	pass # Replace with function body.



func _on_timer_drawing_timeout():
	if is_drawing:
		if is_instance_valid(drawing_line):
			_TimerDrawing.start()
			if drawing_line.points.size() <= 1:
				drawing_safe_position = get_global_mouse_position()
				if drawing_line.points[0].distance_to(drawing_safe_position) > 10:
					var result : bool = drawing_line.build_new_point(drawing_safe_position, true)
					if !result:
						alert_cost_fail()
						return
			else:
				if !is_drawing_meet_collision:
					var vector : Vector2 = get_global_mouse_position() - _RayDrawing.global_position
					_RayDrawing.global_position = drawing_safe_position + vector.normalized()
					_RayDrawing.target_position = get_global_mouse_position() - _RayDrawing.global_position
					_RayDrawing.force_raycast_update()
					var is_safe := true
					if _RayDrawing.is_colliding():
						var area = _RayDrawing.get_collider()
						var object = area
						if area is DetectArea2D:
							object = area.object
						if object is TerrainBarrier or object is TreeLikeLine:
							is_safe = false
					if is_safe:
						drawing_safe_position = get_global_mouse_position()
						var result : bool = drawing_line.build_new_point(drawing_safe_position, true)
						if !result:
							alert_cost_fail()
							return
	pass # Replace with function body.

func _on_leaf_fall_requested(leaf : Leaf):
	emit_signal("leaf_fallen", leaf)
	leaf.fall()
	pass

func _on_growth_point_changed():
	var total_growth_point : float = Data.roots_growth_point + Data.stem_growth_point
	Data.energy.decrease_speed -= normal_energy_cost
	normal_energy_cost = (total_growth_point / 10) * Data.normal_energy_cost_effeciency * Config.NORMAL_ENERGY_COST_RATE
	Data.energy.decrease_speed += normal_energy_cost
	pass

func _on_hour_passed():
	Data.water.update()
	
	var sunlight_level : float = Data.sunlight.value
	var consumed_water := 0.0
	if Data.water.value >= sunlight_level:
		if Data.is_neglect_energy_capacity:
			Data.water.value -= sunlight_level
			consumed_water = sunlight_level
		else:
			var temp : float = Data.energy.capacity - Data.energy.value
			if temp < 0:
				temp = 0
			if sunlight_level <= temp:
				Data.water.value -= sunlight_level
				consumed_water = sunlight_level
			else:
				Data.water.value -= temp
				consumed_water = temp
	else:
		if Data.is_neglect_energy_capacity:
			consumed_water = Data.water.value
			Data.water.value = 0
		else:
			var temp : float = Data.energy.capacity - Data.energy.value
			if temp < 0:
				temp = 0
			if sunlight_level <= temp:
				consumed_water = Data.water.value
				Data.water.value = 0
			else:
				Data.water.value -= temp
				consumed_water = temp
	
	Data.energy.value += consumed_water * Data.photosynthesis_effeciency * Config.PHOTOSYNTHESIS_RATE
	
	Data.water.update()
	Data.energy.update()
	Data.nutrition_n.update()
	Data.nutrition_k.update()
	Data.nutrition_p.update()
	
	if Data.nutrition_n.level == 0:
		Data.photosynthesis_effeciency = 1
		Data.is_pause_leaf_fall = false
	elif Data.nutrition_n.level == 1:
		Data.photosynthesis_effeciency = Config.N_PHOTOSYNTHESIS_EFFECIENCY
		Data.is_pause_leaf_fall = false
	elif Data.nutrition_n.level >= 2:
		Data.photosynthesis_effeciency = Config.N_PHOTOSYNTHESIS_EFFECIENCY
		Data.is_pause_leaf_fall = true
	
	if Data.nutrition_p.level == 0:
		Data.normal_energy_cost_effeciency = 1
	elif Data.nutrition_p.level == 1:
		Data.normal_energy_cost_effeciency = Config.P_ENERGY_COST_1
	elif Data.nutrition_p.level >= 2:
		Data.normal_energy_cost_effeciency = Config.P_ENERGY_COST_2
	
	if Data.nutrition_k.level == 0:
		if is_nutrition_k_working:
			is_nutrition_k_working = false
			Data.water.capacity -= Config.K_CAPACITY_BONUS
		Data.is_neglect_energy_capacity = false
	elif Data.nutrition_k.level == 1:
		if !is_nutrition_k_working:
			is_nutrition_k_working = true
			Data.water.capacity += Config.K_CAPACITY_BONUS
		Data.is_neglect_energy_capacity = false
	elif Data.nutrition_k.level >= 2:
		emit_signal("clear_fog_requested")
	pass
