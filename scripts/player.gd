extends AnimatedSprite2D

@onready var gesture_instance = $Camera2D/CanvasLayer/Gesture
@onready var MAXhp = 5
@onready var MAXmp = 5
@onready var mpbar = $Camera2D/CanvasLayer/ProgressBar

# Tamaño de cada tile
var tile_size = Vector2(16, 16)

func _ready() -> void:
	gesture_instance.maxLengthLine = MAXmp*50
	mpbar.max_value = MAXmp*50
	mpbar.value = MAXmp*50

func _physics_process(delta: float) -> void:
	mpbar.value = MAXmp*50 - gesture_instance.current_length

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
		if event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_position = get_global_mouse_position()
			var direction = (mouse_position - global_position).normalized()
			move_in_direction(Vector2(round(direction.x), round(direction.y)))
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			gesture_instance.classify()

func move_in_direction(direction):
	var new_position = global_position + direction * tile_size
	global_position = new_position
