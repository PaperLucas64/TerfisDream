extends RigidBody2D

#Aquí defines algunas variables: la velocidad mínima y máxima que puede tener tu enemigo, un arreglo con los tipos de "bola" o enemigo, y un generador de números aleatorios.
var Velocidad_Min = 150
var Velocidad_Max = 250
var Tipo_Bola = ["BolaP", "Huevochocolate", "Cucaracha"] #[] Arregle
#var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()  # Opcional, para inicializar la semilla del generador de números aleatorios
	$AnimatedSprite.animation = Tipo_Bola[rng.randi() % Tipo_Bola.size()]
	if $AnimatedSprite.animation == "BolaP":
		$CollisionShape2D.scale.x = 1.8
		$CollisionShape2D.scale.y = 1.8


func _on_Visibilidad_screen_exited():
	queue_free()
	
