extends KinematicBody2D

const SPEED = 500
const TIRO = preload("res://Tiro.tscn")
var self_limite = false
var life = 100
var consciencia = true
var move = Vector2(0, 0)
var inv = false

func _process(delta):
    if consciencia:
        var prev_move = move
        
        if Input.is_action_pressed("ui_left"):
            move.x = -SPEED
        elif Input.is_action_pressed("ui_right"):
            move.x = SPEED
        else:
            move.x = 0
        if Input.is_action_pressed("ui_up"):
            move.y = -SPEED
        elif Input.is_action_pressed("ui_down"):
            move.y = SPEED
        else:
            move.y = 0
        
        move.normalized() 
        move = lerp(prev_move, move, 0.3)
        move_and_slide(move)

        look_at(get_global_mouse_position())

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
    if life > 0 && !inv:
        knockback(fonte_do_dano)
        life -= quanto_de_dano
        $Timer.start()
        $CanvasLayer/UI/Text.text = str(life)
        if life <= 0:
            print("game over")
            consciencia = false
            modulate = Color(0, 0, 0)
            $Col.queue_free()
    if inv:
        knockback(fonte_do_dano)

func knockback(dano_do_fonte):
    var fonte = dano_do_fonte.position
    var prev_dir = rotation
    look_at(fonte)
    move = Vector2(-5000, 0).rotated(rotation)
    rotation = prev_dir
    inv = true
    $Sprite.modulate = Color(0.431373, 0.431373, 0.431373, 0.647059)

func _on_Timer_timeout() -> void:
    inv = false
    $Sprite.modulate = Color(1, 1, 1)
