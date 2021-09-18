class_name CircularBullet
extends KinematicBody2D

signal hit

var size_radius : float
var dmg : float
var speed : float
var velocity: Vector2 = Vector2.ZERO
var acceleration: float = 1000.0

var mouse_position
var mouse_radius: float = 10

func _init():
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(delta):
	var mouse_position = get_viewport().get_mouse_position()
	var direction = global_position.direction_to(mouse_position)
#	velocity = velocity
	velocity = direction * speed
	velocity = move_and_slide(velocity)
	if global_position.distance_to(mouse_position) < 10:
		emit_signal("hit")
		queue_free()
	
#	position += transform.x * speed * delta
