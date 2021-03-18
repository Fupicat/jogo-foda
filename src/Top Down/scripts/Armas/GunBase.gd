extends Node2D
class_name GunBase

onready var UI = $"../../CanvasLayer/UI"
var nome
var icone
var bala

func _ready():
    get_parent().get_parent().gun = self
    UI.get_node("Gun_icon").texture = icone

func atire():
    var bala_inst = bala.instance()
    get_parent().get_parent().get_parent().add_child(bala_inst)
    bala_inst.atire($Posicao.global_position)
