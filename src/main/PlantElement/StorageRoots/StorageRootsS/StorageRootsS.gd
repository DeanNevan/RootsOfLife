extends StorageRoots
class_name StorageRootsS

func _ready():
	super._ready()
	energy_cost = Config.COST_STORAGE_ROOTS_S
	capacity_bonus = Config.CAPACITY_STORAGE_ROOTS_S
