extends Node2D

const INIMIGO = preload("res://Top Down/scenes/inimigo.tscn")
var posicao = RandomNumberGenerator.new()
var numero = RandomNumberGenerator.new()
var node_posicao = 0

func _ready():
    timer()

func timer():
    numero.randomize()
    var tempo_determinado = round(numero.randf_range(1, 3))
    $Timer.wait_time = tempo_determinado
    $Timer.start()

func _on_Timer_timeout() -> void:
    posicao.randomize()
    var posicao_ini = round(posicao.randf_range(1,4))
    add_child(INIMIGO.instance())
    $Inimigo.position = get_node("Position2D_"+str(posicao_ini)).position
    timer()
