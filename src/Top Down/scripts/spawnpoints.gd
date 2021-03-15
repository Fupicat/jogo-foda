extends Node2D

const INIMIGO = preload("res://Top Down/scenes/Inimigo.tscn")
onready var posicoes = get_tree().get_nodes_in_group("posicoes")
var pos = 0
var inimigos = 0
var debug = 0

func _ready():
    timer()

func timer():
    randomize()
    var tempo_determinado = round(rand_range(1, 3))
    $Timer.wait_time = tempo_determinado
    $Timer.start()

func _on_Timer_timeout() -> void:
    var instancia = INIMIGO.instance()
    if inimigos != 10:
        inimigos += 1
        pos = posicoes[round(rand_range(0,3))].position
        $"..".add_child(instancia)
        instancia.position = pos
        timer()
