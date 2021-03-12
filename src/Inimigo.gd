extends KinematicBody2D

const SPEED = 300
var life = 100

func _process(delta):
	var player_pos = $"../Player".position
	look_at(player_pos)
	move_and_slide(Vector2(SPEED, 0).rotated(rotation))

func dano(quanto):
	life -= 5
