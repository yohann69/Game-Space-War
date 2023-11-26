extends Node2D

var enemy = preload("res://Game/Enemy.tscn")
@export var MAX_ENEMY = 5
@export var ENEMY_TO_DEFEAT = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)

	# Create a node to hold the enemies
	var enemies = Node2D.new()
	enemies.name = "Enemies"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Add the enemies to the enemies node at a random place
	if get_node("Enemies").get_child_count() < MAX_ENEMY - 1 and ENEMY_TO_DEFEAT > 1:
		create_enemy(1, false)
	if get_node("Enemies").get_child_count() < MAX_ENEMY and ENEMY_TO_DEFEAT == 1:
		create_enemy(5, true)


func create_enemy(lives, final_boss):
	var new_enemy = enemy.instantiate()
	new_enemy.NUMBER_OF_LIVES = lives
	new_enemy.IS_FINAL_BOSS = final_boss
	new_enemy.position = Vector2(randf_range(0, get_viewport().size.x), randf_range(0, get_viewport().size.y))
	get_node("Enemies").add_child(new_enemy)
	ENEMY_TO_DEFEAT -= 1
