extends Area2D

const SPEED = 500

func atire(pos):
    position = pos
    look_at(get_parent().get_node("Player").global_position)

func _process(delta):
    position += Vector2(SPEED * delta, 0).rotated(rotation)

func _on_Timer_timeout():
    queue_free()

func _on_Tiro_body_entered(body) -> void:
    if body.has_method("dano") and !body.is_in_group("inimigo"):
        body.dano(15)
        queue_free()
