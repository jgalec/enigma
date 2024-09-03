extends Entity
class_name Enemy

func taking_turn():
	for i in range(movement):
		var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		move_to_direction(direction)
	turn_ended.emit()
