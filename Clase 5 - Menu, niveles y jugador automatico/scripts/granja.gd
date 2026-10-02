extends Node2D

var escena_manzana = load("res://escenas/manzana.tscn")


func _ready() -> void:
	Global.cargar()
	actualizar_labels()

	var nueva_manzana

	for n in range(0, 10):
		nueva_manzana = escena_manzana.instantiate()
		add_child(nueva_manzana)
		nueva_manzana.position.x = randi_range(16, 304)
		nueva_manzana.position.y = randi_range(16, 164)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://escenas/menu.tscn")


func sumar_punto():
	Global.puntos += 1

	if Global.puntos > Global.max_puntos:
		Global.max_puntos = Global.puntos
		Global.grabar()

	actualizar_labels()


func actualizar_labels():
	$CanvasLayer/Control/MarginContainer/HBoxContainer/LabelPuntos.text = "puntos: " + str(Global.puntos)
	$CanvasLayer/Control/MarginContainer/HBoxContainer/LabelPuntosMax.text = "max: " + str(Global.max_puntos)
