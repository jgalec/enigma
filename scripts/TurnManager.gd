extends Node

var entities : Array[Entity] = []
var current_turn = 0
@export var initial_turn_entity : Entity

func _ready():
	if initial_turn_entity:
		entities.append(initial_turn_entity)
		entities[current_turn].emit_signal("turn_started")

func get_turn_entity():
	return entities[current_turn]

func next_turn():
	if current_turn >= len(entities)-1:
		current_turn = 0
	else:
		current_turn += 1
	entities[current_turn].emit_signal("turn_started")

func is_this_my_turn(entity : Entity) -> bool:
	return get_turn_entity() == entity
