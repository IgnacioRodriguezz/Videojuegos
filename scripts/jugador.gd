extends CharacterBody2D

@export var numero_de_jugador: int = 1

var direccion
var velocidad = 60


func _physics_process(delta: float) -> void:
	if numero_de_jugador == 1:
		direccion = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	else:
		direccion = Input.get_vector("tecla_a", "tecla_d", "tecla_w", "tecla_s")

	direccion = direccion.normalized()

	velocity = direccion * velocidad
	move_and_slide()
