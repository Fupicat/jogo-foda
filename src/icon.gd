extends KinematicBody2D

const SPEED = 500
const TIRO = preload("res://Tiro.tscn")
var self_limite = false
var life = 100
var consciencia = true

func _process(delta):
    if consciencia:
        var move = Vector2(0, 0)
        var direcao = 0
        
        if Input.is_action_pressed("ui_left"):
            move.x -= SPEED
            direcao = 270
        if Input.is_action_pressed("ui_right"):
            move.x += SPEED
            direcao = 90
        if Input.is_action_pressed("ui_up"):
            move.y -= SPEED
            direcao = 0
        if Input.is_action_pressed("ui_down"):
            move.y += SPEED
            direcao = 180
        
        $Sprite.rotation = lerp($Sprite.rotation, deg2rad(direcao), 0.5)
        move_and_slide(move)

        $"Sprite/Mão".look_at(get_global_mouse_position())

func _input(event):
    if event.is_action_pressed("ui_accept") && self_limite == false:
        atire()

func atire():
    if consciencia:
        $"..".add_child(TIRO.instance())

func _on_Limite_mouse_entered() -> void:
    self_limite = true

func _on_Limite_mouse_exited() -> void:
    self_limite = false

func dano(quanto_de_dano, fonte_do_dano):
    if life > 0:
        knockback(fonte_do_dano)
        life -= quanto_de_dano
        if life <= 0:
            print("game over")
            consciencia = false
            modulate = Color(0, 0, 0)
            $Col.queue_free()

func knockback(dano_do_fonte):
    var fonte = dano_do_fonte.position
    look_at(fonte)
    move_and_slide(Vector2(500, 0))
