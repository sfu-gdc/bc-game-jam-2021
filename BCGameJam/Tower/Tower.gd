class_name Tower
extends Node2D

signal timeout

# stats of the tower
var stats

# radius of size of the tower, attack range, attack cool down, and the attack damage of the tower
var size_radius : float
var attack_range : float
var attack_cool_down : float
var attack_dmg : float

# once the time counter reaches attack_cool_down, fire the bullet
var time_counter : float = 100.0
var size_counter : float = 1.0

var SimpleBullet = preload("res://Bullets/SimpleBullet/SimpleBullet.tscn")

# ratio between bullet and tower
const bullet_to_tower_ratio : float = 0.2

# nodes
onready var GameScene : Node = get_node("/root/World")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("timeout", self, "fire_bullet")
	var width : float = 2 * size_radius
	_set_size($Sprite, width)


# whenever time reaches cool down, fire bullets and reset time
func _process(delta):
	time_counter += delta
	if time_counter > attack_cool_down:
		emit_signal("timeout")
		time_counter = 0
#	_scale_size(size_counter)
#	size_counter -= delta / scale_second


func fire_bullet():
	# get the bullet node
	var bullet = SimpleBullet.instance()
	bullet.dmg = attack_dmg
	
	# set the size of bullet srpte
	_set_bullet_size(bullet)
	
	# set the size of bullet's circular shape
	_set_bullet_collision_area_radius(bullet)
	
	# add the bullet to the tower node
	GameScene.add_child(bullet)
	
	# set the bullet position to be the tower position
	bullet.global_position.x = global_position.x
	bullet.global_position.y = global_position.y - 60



func _set_bullet_size(bullet: CircularBullet):
	var bullet_sprite: Sprite = bullet.get_node("Sprite")
	var width : float = 2 * size_radius * bullet_to_tower_ratio
	_set_size(bullet_sprite, width)


func _set_bullet_collision_area_radius(bullet: CircularBullet):
	var shape: CircleShape2D = bullet.get_node("Shape").get_shape()
	bullet.size_radius = size_radius * bullet_to_tower_ratio
	shape.set_radius(bullet.size_radius)


# set the size of the sprite to a new width
func _set_size(sprite_node: Sprite, new_width: float) -> void:
	var width : float = sprite_node.get_texture().get_width()
	var new_ratio = new_width / width
	_scale_size(sprite_node, new_ratio)

# scale the sprite, for internal use
func _scale_size(sprite_node: Sprite, scale: float) -> void:
	sprite_node.set_scale(Vector2(scale, scale));
