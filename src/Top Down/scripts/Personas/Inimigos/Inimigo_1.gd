extends Person

onready var player = $"../Player"
onready var spawn = $"../SpawnPoints"
const TIRO = preload("res://Top Down/scenes/Armas/Tiro/TiroInimigo.tscn")

func _init():
    speed = 150

func _ready():
# warning-ignore:return_value_discarded
    connect("death", spawn, "_on_Inimigo_death")

func mov_custom():
    var player_pos = player.position
    look_at(player_pos)
    move = Vector2(speed, 0).rotated(rotation)

func shoot():
    var bala_inst = TIRO.instance()
    get_parent().add_child(bala_inst)
    bala_inst.atire(global_position)

# Sinais ///////////////////////////////

func _on_Area2d_body_entered(body) -> void:
    if consciencia:
        if body.is_in_group("player"):
            body.dano(5, self)

func _on_Timer_timeout() -> void:
    if consciencia:
        shoot()
