extends State
class_name EnemyIdle

@export var enemy : Entity

var move_direction : Vector2
var wander_time : float

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(0, 1)

func enter():
	randomize_wander()

func update(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()

func physics_update(delta):
	if enemy:
		enemy.move_in_direction(move_direction.normalized())
		print(move_direction)
