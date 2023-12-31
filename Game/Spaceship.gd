extends CharacterBody2D

@export var MAX_SPEED = 500
@export var ACCELERATION = 2000
@export var FRICTION = 1700
@export var ROTATION_SPEED = 2.5

@onready var axis = Vector2.ZERO

var laser = preload("res://Game/Laser.tscn")

func _physics_process(delta):
	move(delta)
	rotate_ship(delta)

	if Input.is_action_just_pressed("space"):
		shoot()

func get_input_axis():
	axis.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	axis.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	return axis.normalized()

func move(delta):
	axis = get_input_axis()

	if axis == Vector2.ZERO:
		apply_friction(FRICTION * delta)
	else:
		apply_movement(axis * ACCELERATION * delta)

	move_and_slide()

func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else:
		velocity = Vector2.ZERO

func apply_movement(accel):
	velocity += accel
	velocity = velocity.limit_length(MAX_SPEED)

func rotate_ship(delta):
	if axis != Vector2.ZERO:
		var target_angle = Vector2.RIGHT.angle_to(axis) + PI/2
		rotation = lerp_angle(rotation, target_angle, ROTATION_SPEED * delta)

func shoot():
	var laser_instance = laser.instantiate()
	# Set the laser's position with an offset of 90 pixels in the direction the spaceship is pointing to avoid the laser colliding with the spaceship
	laser_instance.position = position + Vector2.RIGHT.rotated(rotation - PI/2) * 90
	laser_instance.rotation = rotation
	# Set the laser's velocity based on the spaceship's rotation
	laser_instance.velocity = Vector2.RIGHT.rotated(rotation - PI/2) * laser_instance.speed
	get_parent().add_child(laser_instance)
