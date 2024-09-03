extends Entity
class_name Enemy

func taking_turn():
	for i in range(movement):
		var direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
		move_to_direction(direction)
		await get_tree().create_timer(0.5).timeout # Espera entre movimientos para visualizar mejor el turno
	emit_signal("turn_ended") # Emitir señal cuando el turno termina
