extends Area2D

var Velocidad = 400
var Movimiento = Vector2() #Vector se usa para indicar posición y usamos Vector2 porque estamos en 2d
var Touch = false
var P #para saber la posición del evento touch
var L = 50 #para saber la longitud del evento touch
signal choque

#Función para el Touch (Tactil)
func _input(event):
	if event is InputEventScreenTouch: #este evento es un evento touch?
		if event.pressed == true: #si esta precionado
			Touch = true #la variable touch pasa de falso a verdadero
			P = event.position #Acá se guarda la posición del evento touch
		else:
			Touch = false #y si no que vuelva a su posición

			pass

func _ready():
	hide()

func _process(delta):
	Movimiento = Vector2()
	if Touch:
		if abs(global_position.x - P.x) > L: 
			if global_position.x > P.x:
				Movimiento.x -=1
			else:
				Movimiento.x +=1
		if abs(global_position.y - P.y) > L:
			if global_position.y > P.y:
				Movimiento.y -=1
			else:
				Movimiento.y +=1
		
	if Movimiento.length() > 0:
		Movimiento = Movimiento.normalized()*Velocidad
	position += Movimiento * delta

func _on_body_entered(_body):
	hide()
	emit_signal("choque")
	$CollisionShape2D.set_deferred("disable", true)
	
func inicio(p):
	position = p
	show()
	$CollisionShape2D.disabled = false

