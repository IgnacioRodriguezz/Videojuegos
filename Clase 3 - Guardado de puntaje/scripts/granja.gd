extends Node2D

var escena_manzana = load("res://escenas/manzana.tscn")


func _ready() -> void:
	Global.cargar()
	$LabelPuntos.text = "puntos: " + str(Global.puntos)
	$LabelPuntosMax.text = "max: " + str(Global.max_puntos)

	var nueva_manzana

	for n in range(0, 10):
		nueva_manzana = escena_manzana.instantiate()
		add_child(nueva_manzana)
		nueva_manzana.position.x = randi_range(16, 304)
		nueva_manzana.position.y = randi_range(16, 164)


func sumar_punto():
	Global.puntos += 1
	$LabelPuntos.text = "puntos: " + str(Global.puntos)

	if Global.puntos > Global.max_puntos:
		Global.max_puntos = Global.puntos
		$LabelPuntosMax.text = "max: " + str(Global.max_puntos)
		Global.grabar()
