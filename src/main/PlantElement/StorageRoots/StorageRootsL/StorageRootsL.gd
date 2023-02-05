extends StorageRoots
class_name StorageRootsL

func _ready():
	super._ready()
	energy_cost = Config.COST_STORAGE_ROOTS_L
	capacity_bonus = Config.CAPACITY_STORAGE_ROOTS_L
