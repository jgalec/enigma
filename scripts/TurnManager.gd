extends Node

var entities : Array[Entity] = []
var current_turn = 0
@export var initial_turn_entity : Entity
var camera : Camera2D

func _ready():
	camera = get_viewport().get_camera_2d()
	if initial_turn_entity:
		entities.append(initial_turn_entity)
		entities[current_turn].emit_signal("turn_started")

func get_turn_entity():
	return entities[current_turn]

func next_turn():
	current_turn += 1
	if current_turn >= len(entities):
		current_turn = 0
	entities[current_turn].emit_signal("turn_started")
	
	# Cambiar el objetivo de la cámara
	change_camera_target(entities[current_turn])

func process_turns():
	while true:
		await entities[current_turn].turn_ended
		next_turn()

func is_this_my_turn(entity : Entity) -> bool:
	return get_turn_entity() == entity

func change_camera_target(new_target: Node2D):
	if camera:
		# Desconectar la cámara del nodo actual
		camera.get_parent().remove_child(camera)
		# Conectar la cámara al nuevo objetivo
		new_target.add_child(camera)
		# Ajustar la posición de la cámara para que coincida con la del nuevo objetivo
		camera.position = Vector2.ZERO
