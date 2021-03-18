extends KinematicBody2D

const SPEED = 300
var life = 100
var consciencia = true
onready var player = $"../Player"
onready var spawn = $"../SpawnPoints"
var move = Vector2()

signal death

func _ready():
    connect("death", player, "_on_Inimigo_death")
    connect("death", spawn, "_on_Inimigo_death")

func _process(delta):
    if consciencia:
        var prev_move = move
        
        var player_pos = player.position
        look_at(player_pos)
        move = Vector2(SPEED, 0).rotated(rotation)
        
        move = lerp(prev_move, move, 0.3)
        move_and_slide(move)

func dano(quanto_de_dano, fonte_do_dano = null):
    if life > 0:
        if fonte_do_dano:
            knockback(fonte_do_dano)
        life -= quanto_de_dano
        if life <= 0:
            print("morri")
            consciencia = false
            modulate = Color(0, 0, 0)
            emit_signal("death")
            $Col.queue_free()

func knockback(dano_do_fonte):
    var fonte = dano_do_fonte.position
    var prev_dir = rotation
    look_at(fonte)
    move = Vector2(-5000, 0).rotated(rotation)
    rotation = prev_dir

func _on_Area2d_body_entered(body) -> void:
    if consciencia:
        if body.is_in_group("player"):
            body.dano(5, self)
