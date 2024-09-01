extends AnimatedSprite2D

# Velocidad de movimiento (en celdas por segundo)
@export var speed = 100

# Referencia al TileMap
@export var tilemap : TileMapLayer

# Dirección de movimiento actual
var move_direction = Vector2.ZERO
var move_timer = 0.0
var target_position = Vector2.ZERO
var is_moving = false

func _ready():
	target_position = global_position

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.key_label:
				KEY_UP:
					move_direction = Vector2(0, -1)
				KEY_DOWN:
					move_direction = Vector2(0, 1)
				KEY_LEFT:
					move_direction = Vector2(-1, 0)
				KEY_RIGHT:
					move_direction = Vector2(1, 0)
		else:
			# Detener el movimiento cuando se suelta la tecla
			move_direction = Vector2.ZERO

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var mouse_position = get_global_mouse_position()
				var direction = (mouse_position - global_position).normalized()
				move_direction = Vector2(round(direction.x), round(direction.y))
			else:
				move_direction = Vector2.ZERO

func _process(delta):
	if is_moving:
		global_position = global_position.move_toward(target_position, speed * delta)
		if global_position.distance_to(target_position) < 1:
			global_position = target_position
			is_moving = false
	elif move_direction != Vector2.ZERO:
		move_timer -= delta
		if move_timer <= 0:
			move_in_direction(move_direction)
			move_timer = 1.0 / speed

func move_in_direction(direction):
	var cell_pos = tilemap.local_to_map(position)
	var new_cell = cell_pos + Vector2i(direction)
	var new_cell_pos = global_position + direction * tilemap.tile_set.tile_size.x
	var data = tilemap.get_cell_tile_data(new_cell)
	if data and data.get_custom_data("walkable"):
		target_position = new_cell_pos
		is_moving = true
