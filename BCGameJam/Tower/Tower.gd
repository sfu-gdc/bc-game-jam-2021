class_name Tower
extends Node2D
signal timeout


export(float) var size_radius : float
export(float) var attack_range : float
export(float) var attack_cool_down : float
export(float) var attack_dmg : float

# once the time counter reaches attack_cool_down, fire the bullet
var time_counter : float = 100.0
var size_counter : float = 1.0

var SimpleBullet = preload("res://Bullets/SimpleBullet/SimpleBullet.tscn")


# the time it takes to scale the 
const scale_second : float = 10.0

onready var GameScene : Node = get_node("/root/Main")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("timeout", self, "fire_bullet")
	var width : float = 2 * size_radius
	_set_size($Sprite, width)


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
	var bullet_sprite: Sprite = bullet.get_node("Sprite")
	var width : float = 2 * size_radius * 0.2
	_set_size(bullet_sprite, width)
	# set the size of bullet's circular shape
	var shape: CircleShape2D = bullet.get_node("Shape").get_shape()
	bullet.size_radius = size_radius * 0.2
	shape.set_radius(bullet.size_radius)
	# add the bullet to the tower node
	GameScene.add_child(bullet)
	bullet.global_position.x = global_position.x
	bullet.global_position.y = global_position.y


func _set_size(sprite_node: Sprite, new_width: float) -> void:
	var width : float = sprite_node.get_texture().get_width()
	var new_ratio = new_width / width
	_scale_size(sprite_node, new_ratio)


func _scale_size(sprite_node: Sprite, scale: float) -> void:
	sprite_node.set_scale(Vector2(scale, scale));
