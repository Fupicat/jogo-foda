extends Area2D

const SPEED = 500

func _ready():
    position = $"../Player/Sprite/Posicao".global_position
    look_at(get_global_mouse_position())

func _process(delta):
    position += Vector2(SPEED * delta, 0).rotated(rotation)

func _on_Timer_timeout():
    queue_free()

func _on_Tiro_body_entered(body) -> void:
    if body.has_method("dano") and !body.is_in_group("player"):
        body.dano(15)
        queue_free()
