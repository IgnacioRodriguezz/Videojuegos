# Diseño y Desarrollo de Videojuegos II

Ignacio Rodríguez · Comisión 1 · 2º cuatrimestre 2026
Docente: Alejandro Crapanzano

Una carpeta por clase. Cada una es un proyecto de Godot independiente con el trabajo correspondiente a esa clase.

| Carpeta | Clase | Tema |
|---|---|---|
| `Clase 2 - Movimiento` | 21/08/2026 | Movimiento en 8 direcciones con `delta`, mapa de entrada y organización del proyecto |
| `Clase 3 - Guardado de puntaje` | 28/08/2026 | Persistencia con `FileAccess`: guardar el puntaje máximo en `user://` |

Hecho en Godot 4.6. Para abrir una clase, importar la carpeta correspondiente como proyecto.

## Clase 3 — Guardado de puntaje

Se agrega sobre el proyecto de la clase anterior:

- Autoload `Global` (`scripts/global.gd`) con `puntos`, `max_puntos` y el archivo `user://guardado.dat`.
- `grabar()` abre el archivo en modo `WRITE` y guarda el máximo con `store_var()`.
- `cargar()` lo abre en modo `READ` y lo recupera con `get_var()`, chequeando antes con `file_exists()` para que no aborte si el archivo todavía no existe.
- `LabelPuntos` y `LabelPuntosMax` en la escena `Granja`, actualizados al juntar cada manzana y también en el `_ready()`.

El puntaje máximo se guarda en `user://` y no en `res://`, porque al exportar el proyecto la carpeta de recursos queda de solo lectura.
