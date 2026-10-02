extends CharacterBody2D

var direccion
var velocidad = 50

# a donde va cuando ya no quedan manzanas
var posicion_final = Vector2(16, 16)


func _physics_process(delta: float) -> void:
	var posicion_manzana

	# de todas las que estan en el grupo, agarra la primera
	var nodo_manzana = get_tree().get_first_node_in_group("manzanas")

	if nodo_manzana != null:
		posicion_manzana = nodo_manzana.position
	else:
		posicion_manzana = posicion_final

	direccion = Vector2(0, 0)

	if position.x > posicion_manzana.x:
		direccion.x = -1
	if position.x < posicion_manzana.x:
		direccion.x = 1
	if position.y > posicion_manzana.y:
		direccion.y = -1
	if position.y < posicion_manzana.y:
		direccion.y = 1

	direccion = direccion.normalized()

	velocity = direccion * velocidad
	move_and_slide()
