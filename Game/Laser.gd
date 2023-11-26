extends Area2D

@export var speed = 1000
var velocity = Vector2() # Declare the velocity variable

func _ready():
	# Connect the body_entered signal
	connect("body_entered", Callable(self, "_on_Laser_body_entered"))

func _physics_process(delta):
	# Move at the speed in the direction of the velocity
	position += velocity * delta

func _on_Laser_body_entered(body):
	print("Laser collided with body", body.name)

	# If the body is of type CharacterBody2D (enemy), remove a life from it
	if body is CharacterBody2D:
		body.NUMBER_OF_LIVES -= 1

	# When the laser hits something, queue it for deletion
	queue_free()
