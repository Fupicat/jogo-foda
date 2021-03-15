extends KinematicBody2D

const SPEED = 300
var life = 100
var consciencia = true

signal death

func _process(delta):
    if consciencia:
        var player_pos = $"../Player".position
        look_at(player_pos)
        move_and_slide(Vector2(SPEED, 0).rotated(rotation))

func dano(quanto_de_dano):
    if life > 0:
        life -= quanto_de_dano
        if life <= 0:
            print("morri")
            consciencia = false
            modulate = Color(0, 0, 0)
            emit_signal("death")
            $Col.queue_free()

func _on_Area2d_body_entered(body) -> void:
    if consciencia:
        if body.is_in_group("player"):
            body.dano(5, self)
