extends KinematicBody2D

const SPEED = 500
const TIRO = preload("res://Tiro.tscn")

func _process(delta):
    var move = Vector2(0, 0)
    
    if Input.is_action_pressed("ui_left"):
        move.x -= SPEED
    if Input.is_action_pressed("ui_right"):
        move.x += SPEED
    if Input.is_action_pressed("ui_up"):
        move.y -= SPEED
    if Input.is_action_pressed("ui_down"):
        move.y += SPEED
    
    move_and_slide(move)

func _input(event):
    if event.is_action_pressed("ui_accept"):
        atire()

func atire():
    $"..".add_child(TIRO.instance())
