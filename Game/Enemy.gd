extends CharacterBody2D

@export var NUMBER_OF_LIVES = 1

@export var MAX_SPEED = 200
@export var ACCELERATION = 2000
@export var FRICTION = 1700
@export var ROTATION_SPEED = 2.5
@export var IS_FINAL_BOSS = false
@export var DAMAGE = 1

@onready var axis = Vector2.ZERO


var SKIN = preload("res://Ressources/enemy-ship.png")


func _ready():
	if IS_FINAL_BOSS:
		SKIN = preload("res://Ressources/enemy-boss-ship.png")
		
	get_node("Skin").texture = SKIN

	

func _physics_process(delta):
	move(delta)
	rotate_ship(delta)
	
	if NUMBER_OF_LIVES <= 0:
		queue_free()

	# Display the number of lives on top of the spaceship
	get_node("Lives").text = str(NUMBER_OF_LIVES)

func move(delta):
	# Get the direction from the enemy to the spaceship
	var spaceship_position = get_parent().get_parent().get_node("Spaceship").get_position()
	axis = (spaceship_position - position).normalized()

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
