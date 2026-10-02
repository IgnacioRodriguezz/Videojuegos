extends Node2D

var puntos = 0


func _ready() -> void:
	$CanvasLayer/LabelPuntos.text = "manzanas: " + str(puntos)


func sumar_punto():
	puntos += 1
	$CanvasLayer/LabelPuntos.text = "manzanas: " + str(puntos)
