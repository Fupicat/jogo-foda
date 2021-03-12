extends Area2D

const SPEED = 500

func _ready():
	position = $"../Player/Mão/Posicao".global_position
	look_at(get_global_mouse_position())

func _process(delta):
	position += Vector2(SPEED * delta, 0).rotated(rotation)
