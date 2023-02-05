extends StorageRoots
class_name StorageRootsM

func _ready():
	super._ready()
	energy_cost = Config.COST_STORAGE_ROOTS_M
	capacity_bonus = Config.CAPACITY_STORAGE_ROOTS_M
