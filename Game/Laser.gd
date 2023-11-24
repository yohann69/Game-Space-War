extends Area2D

@export var speed = 1000
var velocity = Vector2() # Declare the velocity variable

func _physics_process(delta):
	# Move at the speed in the direction of the velocity
	position += velocity * delta
