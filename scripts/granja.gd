extends Node2D

var escena_manzana = load("res://escenas/manzana.tscn")


func _ready() -> void:
	var nueva_manzana

	for n in range(0, 10):
		nueva_manzana = escena_manzana.instantiate()
		add_child(nueva_manzana)
		nueva_manzana.position.x = randi_range(16, 304)
		nueva_manzana.position.y = randi_range(16, 164)
