extends KinematicBody2D

const SPEED = 500
const TIRO = preload("res://Tiro.tscn")
var self_limite = false
var life = 100
var consciencia = true
var move = Vector2(0, 0)
var direcao = 0

func _process(delta):
    if consciencia:
        var prev_move = move
        
        if Input.is_action_pressed("ui_left"):
            move.x = -SPEED
            direcao = 270
        elif Input.is_action_pressed("ui_right"):
            move.x = SPEED
            direcao = 90
        else:
            move.x = 0
        
        if Input.is_action_pressed("ui_up"):
            move.y = -SPEED
            direcao = 0
        elif Input.is_action_pressed("ui_down"):
            move.y = SPEED
            direcao = 180
        else:
            move.y = 0
        
        move.normalized()
        
        $Sprite.rotation = lerp_angle($Sprite.rotation, deg2rad(direcao), 0.5)
        move = lerp(prev_move, move, 0.3)
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
    var prev_dir = rotation
    look_at(fonte)
    move = Vector2(-5000, 0).rotated(rotation)
    rotation = prev_dir
