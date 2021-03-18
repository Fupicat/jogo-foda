extends Area2D

func _on_Explosao_body_entered(body):
    if body.has_method("dano"):
        body.dano(30, self)
