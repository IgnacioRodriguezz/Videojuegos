# Diseño y Desarrollo de Videojuegos II

Ignacio Rodríguez · Comisión 1 · 2º cuatrimestre 2026
Docente: Alejandro Crapanzano

Una carpeta por clase. Cada una es un proyecto de Godot independiente con el trabajo correspondiente a esa clase.

| Carpeta | Clase | Tema |
|---|---|---|
| `Clase 2 - Movimiento` | 21/08/2026 | Movimiento en 8 direcciones con `delta`, mapa de entrada y organización del proyecto |
| `Clase 3 - Guardado de puntaje` | 28/08/2026 | Persistencia con `FileAccess`: guardar el puntaje máximo en `user://` |
| `Clase 4 - Camara, audio, parallax y particulas` | 11/09/2026 | Camera2D que sigue al jugador, AudioManager y buses, Parallax2D y partículas |
| `Clase 5 - Menu, niveles y jugador automatico` | 25/09/2026 | Nodos Control, menú principal, cambio de escena y un jugador que se maneja solo |
| `Clase 6 - Animacion con AnimationPlayer` | 02/10/2026 | Animación por keyframes: la vaca va, come la planta y vuelve |

Hecho en Godot 4.6. Para abrir una clase, importar la carpeta correspondiente como proyecto.

## Clase 3 — Guardado de puntaje

Se agrega sobre el proyecto de la clase anterior:

- Autoload `Global` (`scripts/global.gd`) con `puntos`, `max_puntos` y el archivo `user://guardado.dat`.
- `grabar()` abre el archivo en modo `WRITE` y guarda el máximo con `store_var()`.
- `cargar()` lo abre en modo `READ` y lo recupera con `get_var()`, chequeando antes con `file_exists()` para que no aborte si el archivo todavía no existe.
- `LabelPuntos` y `LabelPuntosMax` en la escena `Granja`, actualizados al juntar cada manzana y también en el `_ready()`.

El puntaje máximo se guarda en `user://` y no en `res://`, porque al exportar el proyecto la carpeta de recursos queda de solo lectura.

## Clase 4 — Cámara, audio, parallax y partículas

Es un proyecto nuevo, un juego de plataformas, porque los temas de la clase no entraban en el de la granja.

**Cámara.** La `Camera2D` va como **hija del jugador**, así el personaje queda fijo en pantalla y se mueve el escenario. Tiene los límites puestos en las cuatro direcciones, `position_smoothing` para que persiga en vez de pegarse, y el arrastre horizontal y vertical con margen `0.2`.

**Audio.** Los `AudioStreamPlayer` cuelgan de un nodo `AudioManager` que está **afuera** de la manzana. Es la solución al error de la clase: si el reproductor estuviera adentro, el `queue_free()` lo borraría en el mismo frame y el sonido se cortaría a 1/60 de segundo. La manzana lo busca por ruta absoluta:

```gdscript
$"/root/Plataforma/AudioManager/SonidoJuntar".play()
```

Hay dos buses, `FX` y `Music`, definidos en `default_bus_layout.tres`. La música tiene `autoplay` y va al bus `Music`.

**Parallax.** Cuatro capas con `Parallax2D` (no `ParallaxLayer`, que está obsoleto), cada una con su `scroll_scale`: el cielo en 0, las montañas lejanas en 0.2, las del medio en 0.5 y los árboles en 0.75. El `repeat_size` es el ancho de la imagen, 320. El `Sprite2D` queda en `(0,0)` dentro de cada Parallax.

**Partículas.** Un `CPUParticles2D` de lluvia con emisión en rectángulo ancho.

**Interfaz.** El label del puntaje va en un `CanvasLayer` para que no se corra con la cámara.

Los fondos y los audios son propios, hechos para este trabajo.

## Clase 5 — Menú, niveles y jugador automático

Se agrega sobre el proyecto de la granja.

**Menú.** Escena de interfaz de usuario con la jerarquía de contenedores: `Control` → `MarginContainer` → `VBoxContainer`. El título es un `RichTextLabel` con BBCode, combinando los efectos `wave` y `rainbow`. Abajo van los botones de nivel 1, nivel 2 y salir, más un `HSlider` de volumen dentro de un `HBoxContainer` para que quede al lado de su label.

**Cambio de escena.** Las señales `pressed` de los botones van a `scripts/menu.gd`:

```gdscript
get_tree().change_scene_to_file("res://escenas/granja.tscn")
get_tree().quit()
```

Desde cualquiera de los dos niveles, `ui_cancel` (Escape) vuelve al menú.

**Los dos niveles.** `granja2.tscn` es el mismo nivel con las cajas en otra posición. El puntaje no se pierde al cambiar de nivel porque vive en el autoload `Global` de la clase anterior.

**Interfaz dentro del nivel.** Los labels de puntaje pasaron a un `CanvasLayer` → `Control` → `MarginContainer` → `HBoxContainer`, con **Expand** en el Container Sizing de cada label: sin eso cada uno ocupa solo lo que mide su texto y la alineación no tiene efecto, que es lo que quedó pendiente de resolver en la clase.

**Jugador automático.** `scripts/jugador_auto.gd` compara su posición con la de la manzana en cada eje y arma el `Vector2` de dirección. Busca el objetivo con

```gdscript
get_tree().get_first_node_in_group("manzanas")
```

y chequea que no sea nulo: cuando ya no quedan manzanas, se va a una posición fija en la esquina.

## Clase 6 — Animación con AnimationPlayer

Proyecto aparte, sin scripts: toda la animación está hecha desde la línea de tiempo del `AnimationPlayer`, que es como se vio en clase.

La animación `caminar` dura **20 segundos** y tiene tres pistas:

| Pista | Propiedad | Qué hace |
|---|---|---|
| 0 | `Vaca:position` | Keyframes en 0, 8, 10 y 18 s: va del punto A al B, espera, y vuelve |
| 1 | `Vaca:flip_h` | En 10 s se da vuelta para volver mirando hacia el otro lado |
| 2 | `Planta:texture` | En 9 s cambia el sprite de la planta con flores al brote, para que se vea que se la comió |

Las dos últimas pistas usan **update discreto** (`update = 1`): el valor salta de uno a otro en vez de interpolarse, que es lo que corresponde para un booleano y para una textura.

Los sprites son los mismos tiles de Kenney Tiny Farm que vienen usándose desde la clase 2: la vaca es `tile_0120`, la planta entera `tile_0030` y el brote `tile_0029`. El pasto es propio.
