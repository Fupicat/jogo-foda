extends Node2D
class_name GunBase

var nome
var icone
var bala

func _ready():
    owner.gun = self

func atire():
    var bala_inst = bala.instance()
    owner.get_parent().add_child(bala_inst)
    bala_inst.atire($Posicao.global_position)
