extends Entity
class_name Player

func _input(event: InputEvent) -> void:
	if TurnManager.is_this_my_turn(self) and event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_position = get_global_mouse_position()
			var direction = (mouse_position - global_position).normalized()
			if not move_to_direction(direction):
				turn_ended.emit()
