extends Node

@export var STAMP_PER_HOUR := 120

@export var SUNLIGHT_LEVEL_SUN_PER_RAYCAST := 1.0
@export var SUNLIGHT_LEVEL_MOON_PER_RAYCAST := 0.2

@export var DIRT_S_WATER := 0.2
@export var DIRT_M_WATER := 0.5
@export var DIRT_L_WATER := 0.8
@export var DIRT_XL_WATER := 1.0
@export var WATER_WATER := 5.0

@export var WATER_CAPACITY := 50.0
@export var ENERGY_CAPACITY := 100.0

@export var GROWTH_POINT_LEAF_S := 3.0
@export var GROWTH_POINT_LEAF_M := 6.0
@export var GROWTH_POINT_LEAF_L := 9.0
@export var GROWTH_POINT_STORAGE_ROOTS_S := 3.0
@export var GROWTH_POINT_STORAGE_ROOTS_M := 6.0
@export var GROWTH_POINT_STORAGE_ROOTS_L := 9.0
@export var GROWTH_POINT_ROOTS_LINE_LENGTH := 100.0
@export var GROWTH_POINT_STEM_LINE_LENGTH := 100.0

@export var NORMAL_ENERGY_COST_RATE := 1.0
@export var PHOTOSYNTHESIS_RATE := 1.0

@export var N_PHOTOSYNTHESIS_EFFECIENCY := 1.5
@export var P_ENERGY_COST_1 := 0.666
@export var P_ENERGY_COST_2 := 0.333
@export var K_CAPACITY_BONUS := 50.0

@export var TREE_LIKE_LINE_COST_RATE := 1.0

@export var COST_LEAF_S := 15.0
@export var COST_LEAF_M := 20.0
@export var COST_LEAF_L := 30.0
@export var COST_STORAGE_ROOTS_S := 10.0
@export var COST_STORAGE_ROOTS_M := 20.0
@export var COST_STORAGE_ROOTS_L := 30.0

@export var CAPACITY_STORAGE_ROOTS_S := 20.0
@export var CAPACITY_STORAGE_ROOTS_M := 40.0
@export var CAPACITY_STORAGE_ROOTS_L := 60.0
