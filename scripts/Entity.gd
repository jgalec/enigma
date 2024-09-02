extends Node2D
class_name Entity

@export var movement : int = 5
@export var tilemaplayer : TileMapLayer
var speed : float = 100.0

signal turn_started
signal turn_ended

func _ready() -> void:
	TurnManager.entities.append(self)
	self.connect("turn_started", _on_turn_started)
	self.connect("turn_ended", _on_turn_ended)

func _process(delta: float) -> void:
	pass

func move_to_direction(direction:Vector2) -> bool:
	if movement > 0:
		print(direction)
		movement -= 1
		return true
	else:
		print("No hay mas movimiento")
		return false

func taking_turn():
	pass

# Manejo del inicio del turno
func _on_turn_started():
	movement = 5 # Reiniciar variables o hacer otras acciones iniciales
	print("Turno iniciado para: ", self)
	taking_turn()

# Manejo del final del turno
func _on_turn_ended():
	if TurnManager.get_turn_entity() == self:
		TurnManager.next_turn()
