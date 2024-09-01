extends Node

class_name TurnQueue

var turn_queue = []

func add_turn(node):
	turn_queue.append(node)

func next_turn():
	# Elimina y devuelve el primer elemento de la cola
	if turn_queue.size() > 0:
		var node = turn_queue.pop_front()
		node.take_turn()
		return node
	return null
