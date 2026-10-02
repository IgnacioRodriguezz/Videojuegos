extends CharacterBody2D

var direccion
var velocidad = 60


func _physics_process(delta: float) -> void:
	direccion = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	direccion = direccion.normalized()

	velocity = direccion * velocidad
	move_and_slide()
