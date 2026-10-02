extends Node

var puntos = 0
var max_puntos = 0
var nombre_archivo = "user://guardado.dat"


func grabar():
	var archivo = FileAccess.open(nombre_archivo, FileAccess.WRITE)
	archivo.store_var(max_puntos)
	archivo.close()


func cargar():
	if FileAccess.file_exists(nombre_archivo):
		var archivo = FileAccess.open(nombre_archivo, FileAccess.READ)
		max_puntos = archivo.get_var()
		archivo.close()
