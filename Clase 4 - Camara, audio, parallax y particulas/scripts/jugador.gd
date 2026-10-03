extends CharacterBody2D

var velocidad = 90
var fuerza_salto = -200
var gravedad = 600

# bandera para que no se pueda saltar dos veces en el aire
var ya_salto = false


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravedad * delta
	else:
		ya_salto = false

	if Input.is_action_just_pressed("ui_accept") and not ya_salto:
		velocity.y = fuerza_salto
		ya_salto = true

	var direccion = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity.x = direccion.x * velocidad

	move_and_slide()
