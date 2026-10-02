extends Sprite2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("jugador"):
		# el reproductor esta afuera de la manzana, en el AudioManager:
		# si estuviera adentro, el queue_free lo borraria antes de que suene
		$"/root/Plataforma/AudioManager/SonidoJuntar".play()
		get_parent().sumar_punto()
		queue_free()
