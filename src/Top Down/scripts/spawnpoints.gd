extends Node2D

const INIMIGO = preload("res://Top Down/scenes/Inimigo.tscn")
const LIMITE = 10
onready var player = $"../Player"
onready var posicoes = get_tree().get_nodes_in_group("posicoes")
var pos = 0
var inimigos = 0
var debug = 0
var inimigos_max = false
var kills = 0

signal wave

func _ready():
    connect("wave", player, "_acionar_wave")
    timer()

func timer():
    randomize()
    var tempo_determinado = round(rand_range(1, 3))
    $Timer.wait_time = tempo_determinado
    $Timer.start()

func _on_Timer_timeout() -> void:
    var instancia = INIMIGO.instance()
    if inimigos != LIMITE && !inimigos_max :
        inimigos += 1
        pos = posicoes[round(rand_range(0,3))].position
        $"..".add_child(instancia)
        instancia.position = pos
        timer()
    elif inimigos >= LIMITE:
        inimigos_max = true

func _on_Inimigo_death() -> void:
    kills += 1
    print(kills)
    if kills >= LIMITE:
        inimigos = 0
        kills = 0
        inimigos_max = false
        emit_signal("wave")
        timer()
