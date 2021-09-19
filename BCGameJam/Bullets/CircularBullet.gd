class_name CircularBullet
extends KinematicBody2D

signal hit

var size_radius : float
var dmg : float
var speed : float
var velocity: Vector2 = Vector2.ZERO
const rocket_acceleration: float = 400.0

var mouse_position
var mouse_radius: float = 10

func _init():
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	mouse_position = get_viewport().get_mouse_position()
	var direction = get_direction_to_enemy(mouse_position)
	
	fire_rocket(speed, direction, delta)
	velocity = move_and_slide(velocity)
	if global_position.distance_to(mouse_position) < 10:
		emit_signal("hit")
		queue_free()


# set the velocity when the tower is firing homing missle
func fire_homing_missle(_speed, direction):
	velocity = direction * _speed


# set the velocity when the tower is firing rockets
func fire_rocket(_speed, direction, _delta):
	velocity = velocity.move_toward(direction * speed, rocket_acceleration * _delta)


# check if the bullet hits the enemy. If the bullet hits, then emit signal, and delete the bullet
func response_when_hit_enemy(enemy_position: Vector2, enemy_size: float):
	if global_position.distance_to(enemy_position) < enemy_size:
		emit_signal("hit")
		queue_free()


# get the direction of bullets towards the enemy
func get_direction_to_enemy(enemy_position: Vector2):
	return global_position.direction_to(mouse_position)
