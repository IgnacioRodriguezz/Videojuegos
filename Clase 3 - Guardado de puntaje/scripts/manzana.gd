extends Sprite2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("jugador"):
		get_parent().sumar_punto()
		queue_free()
