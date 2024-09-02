extends Entity

func _ready():
	target_position = global_position

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var mouse_position = get_global_mouse_position()
				var direction = (mouse_position - global_position).normalized()
				move_direction = Vector2(round(direction.x), round(direction.y))
			else:
				move_direction = Vector2.ZERO
