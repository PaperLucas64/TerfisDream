extends Node

export (PackedScene) var Bola
#@export var Bola: PackedScene
var Score
var rng = RandomNumberGenerator.new()

func _ready():
	randomize()
	nuevo_juego()

func nuevo_juego():
	Score = 0
	$InicioTimer.start() #Inicia el timer 
	$jugador.inicio($PosInicio.position) # Ajusta esta ruta según la jerarquía correcta
 #Toma la posición de inicio en el centro
	$Audiojugando.play()

func game_over():
	$ScoreTimer.stop() #Frena la acumulada de puntos
	$BolaTimer.stop() #Frena a los enemigos
	$AudioGaOver.play()
	$Audiojugando.stop()

func _on_inicio_timer_timeout():
	#Cuando hay un nuevo juego se inicia este timer, y este va a activar, ScoreTimer y Bola Timer
	$BolaTimer.start()
	$ScoreTimer.start()
	


func _on_score_timer_timeout():
	Score +=1

func _on_bola_timer_timeout():
	if Bola and Bola is PackedScene:
		var B = Bola.instance()
		add_child(B)
		var d = $BoCamino/BoPosicion.rotation + PI / 2
		B.position = $BoCamino/BoPosicion.position
		# Aquí ajustamos el uso de rand_range
		d += rng.randf_range(-PI / 4, PI / 4)
		B.rotation = d
		# Ajuste en la línea final para usar randf_range
		var velocidad = rng.randf_range(B.Velocidad_Min, B.Velocidad_Max)
		B.set_linear_velocity(Vector2(velocidad, 0).rotated(d))
	else:
		print("Bola no está correctamente asignada o no es un 'PackedScene'")
