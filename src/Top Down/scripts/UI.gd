extends Control

var wave = 1

func _ready():
    $Timer_Wave.start()

func _acionar_wave():
    wave += 1
    $Waves.visible = true
    $Waves.text = "Wave " + str(wave)
    $Timer_Wave.start()

func update_kills(kills) -> void:
    $Contador_de_kill.text = ("Kills: " + str(kills))

# Sinais /////////////////////////////

func _on_Timer_Wave_timeout() -> void:
    $Waves.visible = false
