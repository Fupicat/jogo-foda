extends Area2D

const EXPLOSAO = preload("res://Top Down/scenes/Explosao.tscn")
const SPEED = 500

func atire(pos):
    position = pos
    look_at(get_global_mouse_position())

func _process(delta):
    position += Vector2(SPEED * delta, 0).rotated(rotation)

func _on_Timer_timeout():
    explode()

func _on_Tiro_body_entered(body) -> void:
    if body.has_method("dano") and !body.is_in_group("player"):
        explode()

func explode():
    var expl = EXPLOSAO.instance()
    get_parent().call_deferred("add_child", expl)
    expl.global_position = global_position
    queue_free()
