extends State
class_name EnemyIdle

@export var enemy : Enemy

var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()

func enter():
	randomize_wander()

func update(delta):
	for i in range(enemy.movement):
		enemy.move_to_direction(move_direction)
