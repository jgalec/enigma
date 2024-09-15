extends Entity
class_name Player

@onready var counter : Label = $"../CanvasLayer/Control/Label"
@onready var next_turn_button : Button = $"../CanvasLayer/Button"

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_position = get_global_mouse_position()
			var direction = (mouse_position - global_position).normalized()
			if move_to_direction(direction):
				counter.text = "MOVEMENT:"+str(movement)
			else:
				counter.text = "NO HAY MAS MOVIMIENTOS"

func taking_turn():
	counter.text = "MOVEMENT:"+str(movement)
	next_turn_button.visible = true

func _on_turn_ended():
	next_turn_button.visible = false
	TurnManager.next_turn()

func _on_button_pressed() -> void:
	get_viewport().set_input_as_handled()
	turn_ended.emit()
