extends KinematicBody2D

const SPEED = 300
var life = 100
var consciencia = true

func _process(delta):
    if consciencia:
        var player_pos = $"../Player".position
        look_at(player_pos)
        move_and_slide(Vector2(SPEED, 0).rotated(rotation))

func _input(event):
    if event.is_action_pressed("ui_home"):
        dano(20)

func dano(quanto_de_dano):
    if life > 0:
        life -= quanto_de_dano
        print(life)
        if life <= 0:
            consciencia = false
            modulate = Color(0, 0, 0)
            $Col.disabled = true
