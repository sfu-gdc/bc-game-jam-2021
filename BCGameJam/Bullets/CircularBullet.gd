class_name CircularBullet
extends KinematicBody2D

signal hit

var size_radius : float
var dmg : float
var target : Area2D
var speed : float
var velocity: Vector2 = Vector2.ZERO
const rocket_acceleration: float = 400.0

var mouse_radius: float = 10

func _init():
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	if is_instance_valid(target):
		var target_position = target.position
		var direction = get_direction_to_enemy(target_position)
		
		fire_rocket(speed, direction, delta)
		velocity = move_and_slide(velocity)
		if global_position.distance_to(target_position) < 10:
			emit_signal("hit")
			queue_free()
	else:
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
	return global_position.direction_to(enemy_position)
