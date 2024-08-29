extends AnimatedSprite2D


# Tamaño de cada tile
var tile_size = Vector2(16, 16)

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.key_label:
				KEY_UP:
					move_in_direction(Vector2(0, -1))
				KEY_DOWN:
					move_in_direction(Vector2(0, 1))
				KEY_LEFT:
					move_in_direction(Vector2(-1, 0))
				KEY_RIGHT:
					move_in_direction(Vector2(1, 0))
	elif event is InputEventMouseButton and event.pressed:
		var mouse_position = get_global_mouse_position()
		var direction = (mouse_position - global_position).normalized()
		move_in_direction(Vector2(round(direction.x), round(direction.y)))

func move_in_direction(direction):
	var new_position = global_position + direction * tile_size
	global_position = new_position
