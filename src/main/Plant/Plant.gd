extends Node2D
class_name Plant

@onready var _Roots = %Roots
@onready var _Stem = %Stem
@onready var _Leaves = %Leaves
@onready var _StorageRoots = %StorageRoots

var scene_roots_line : PackedScene = preload("res://src/main/PlantElement/TreeLike/Roots/RootsLine.tscn")
var scene_stem_line : PackedScene = preload("res://src/main/PlantElement/TreeLike/Stem/StemLine.tscn")
var scene_leaf_s : PackedScene = preload("res://src/main/PlantElement/Leaf/LeafS/LeafS.tscn")
var scene_leaf_m : PackedScene = preload("res://src/main/PlantElement/Leaf/LeafM/LeafM.tscn")
var scene_leaf_l : PackedScene = preload("res://src/main/PlantElement/Leaf/LeafL/LeafL.tscn")
var scene_storage_roots_s : PackedScene = preload("res://src/main/PlantElement/StorageRoots/StorageRootsS/StorageRootsS.tscn")
var scene_storage_roots_m : PackedScene = preload("res://src/main/PlantElement/StorageRoots/StorageRootsM/StorageRootsM.tscn")
var scene_storage_roots_l : PackedScene = preload("res://src/main/PlantElement/StorageRoots/StorageRootsL/StorageRootsL.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func seed_ok(pos : Vector2, normal : Vector2):
	var roots_line : RootsLine = scene_roots_line.instantiate()
	_Roots.add_line(roots_line)
	var stem_line : StemLine = scene_stem_line.instantiate()
	_Stem.add_line(stem_line)
	
	roots_line.begin_build()
	stem_line.begin_build()
	
	roots_line.build_new_point(pos)
	roots_line.build_new_point(pos - normal * 10)
	
	stem_line.build_new_point(pos)
	stem_line.build_new_point(pos + normal * 10)
	
	roots_line.finish_build()
	stem_line.finish_build()
	
	pass
