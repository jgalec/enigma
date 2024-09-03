extends Node2D
class_name Entity

@export var max_movement : int = 3
@export var tilemaplayer : TileMapLayer
var speed : float = 0.2
var movement : int

signal turn_started
signal turn_ended

func _ready() -> void:
	movement = max_movement
	TurnManager.entities.append(self)
	self.connect("turn_started", _on_turn_started)
	self.connect("turn_ended", _on_turn_ended)
	# Buscar nodos hermanos con el nombre TileMapLayer
	var siblings = get_parent().get_children()
	for sibling in siblings:
		if sibling is TileMapLayer:
			tilemaplayer = sibling
			break

func _process(delta: float) -> void:
	pass

func move_to_direction(direction: Vector2) -> bool:
	if movement <= 0:
		print("No hay más movimiento")
		return false
	direction = Vector2(round(direction.x), round(direction.y))
	var cell_pos = tilemaplayer.local_to_map(position)
	var new_cell = cell_pos + Vector2i(direction)
	var new_cell_pos = global_position + direction * tilemaplayer.tile_set.tile_size.x
	if tilemaplayer.get_cell_tile_data(new_cell).get_custom_data("walkable"):
		# Usar tween para movimiento suave
		var tween = create_tween()
		tween.tween_property(self, "position", new_cell_pos, speed) # 0.5 segundos para el movimiento
		movement -= 1
		return true
	else:
		print("Movimiento no permitido, celda no transitable")
		return false

func taking_turn():
	pass

# Manejo del inicio del turno
func _on_turn_started():
	movement = max_movement
	#print("Turno iniciado para: ", self)
	taking_turn()

# Manejo del final del turno
func _on_turn_ended():
	if TurnManager.get_turn_entity() == self:
		TurnManager.next_turn()
