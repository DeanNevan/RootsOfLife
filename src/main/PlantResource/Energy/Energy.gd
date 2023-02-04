extends PlantResource
class_name Energy

func try_consume(cost : float) -> bool:
	if value >= cost:
		value -= cost
		return true
	else:
		return false

func calculate_roots_line_cost(distance : float) -> float:
	return distance / 100.0
	pass

func calculate_stem_line_cost(distance : float) -> float:
	return distance / 100.0
	pass
