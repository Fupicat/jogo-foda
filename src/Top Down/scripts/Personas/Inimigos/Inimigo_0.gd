extends Person

onready var player = $"../Player"
onready var spawn = $"../SpawnPoints"

func _init():
    speed = 300

func _ready():
# warning-ignore:return_value_discarded
    connect("death", spawn, "_on_Inimigo_death")

func mov_custom():
    var player_pos = player.position
    look_at(player_pos)
    move = Vector2(speed, 0).rotated(rotation)

# Sinais ///////////////////////////////

func _on_Area2d_body_entered(body) -> void:
    if consciencia:
        if body.is_in_group("player"):
            body.dano(5, self)
