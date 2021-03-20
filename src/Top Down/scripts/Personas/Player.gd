extends Person

var self_limite = false
var kills = 0
var wave = 1
var gun
var inventario = [preload("res://Top Down/scenes/Armas/Gun.tscn"), preload("res://Top Down/scenes/Armas/Molotov.tscn")]
var selecionado = 0

func _init():
    speed = 500

func _ready():
    gun_next()

func mov_custom():
    if Input.is_action_pressed("ui_left"):
        move.x = -speed
    elif Input.is_action_pressed("ui_right"):
        move.x = speed
    else:
        move.x = 0
    if Input.is_action_pressed("ui_up"):
        move.y = -speed
    elif Input.is_action_pressed("ui_down"):
        move.y = speed
    else:
        move.y = 0
    move.normalized() 
    look_at(get_global_mouse_position())

func _input(event):
    if event.is_action_pressed("ui_accept") && self_limite == false:
        atire()
    if event.is_action_pressed("next"):
        gun_next()

func atire():
    if consciencia:
        gun.atire()

func inv():
    inv = true
    $Sprite.modulate = Color(0.431373, 0.431373, 0.431373, 0.647059)

func dano_custom(fonte_do_dano):
    if not inv and consciencia:
        inv()
        $Timer.start()
        $CanvasLayer/UI/Vida.text = str(life)
    if inv:
        if fonte_do_dano:
            knockback(fonte_do_dano)

func gun_next():
    selecionado += 1
    gun.queue_free()
    if selecionado >= len(inventario):
        selecionado = 0
    $Sprite.add_child(inventario[selecionado].instance())

# Sinais ///////////////////////////////

func _on_Limite_mouse_entered() -> void:
    self_limite = true

func _on_Limite_mouse_exited() -> void:
    self_limite = false

func _on_Timer_timeout() -> void:
    inv = false
    $Sprite.modulate = Color(1, 1, 1)
