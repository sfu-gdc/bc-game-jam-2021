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
var cost: int

# Hover related
var draw_attack_range = false
var attack_range_color = Color(1, 0, 0, 0.3)
var hover_alpha = 0.75

# once the time counter reaches attack_cool_down, fire the bullet
var time_counter : float = 0.0
var size_counter : float = 1.0

var targets = []
var SimpleBullet = preload("res://Bullets/SimpleBullet/SimpleBullet.tscn")

# ratio between bullet and tower
const bullet_to_tower_ratio : float = 0.2

# nodes
onready var GameScene : Node = get_node("/root/World")
onready var collisionRange = get_node("Area/Shape")

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("timeout", self, "fire_bullet")
	var width : float = 2 * size_radius
	_set_size($Sprite, width)
	collisionRange.shape.set_radius(attack_range)
	get_node("AudioStreamPlayer").play()
	
	
func _draw():
	if draw_attack_range:
		draw_circle(Vector2(0, 0), attack_range, attack_range_color)

# whenever time reaches cool down, fire bullets and reset time
func _process(delta):
	time_counter += delta
	if time_counter > attack_cool_down:
		emit_signal("timeout")
		time_counter = 0
#	_scale_size(size_counter)
#	size_counter -= delta / scale_second


func fire_bullet():
	if(targets.size() <= 0): return
	
	# get the bullet node
	var bullet = SimpleBullet.instance()
	bullet.dmg = attack_dmg
	bullet.target = targets[0]
	
	# set the size of bullet srpte
	_set_bullet_size(bullet)
	
	# set the size of bullet's circular shape
	_set_bullet_collision_area_radius(bullet)
	
	# add the bullet to the tower node
	GameScene.add_child(bullet)
	
	# set the bullet position to be the tower position
	bullet.global_position.x = get_node("Sprite/SpriteTop/BulletSource").global_position.x
	bullet.global_position.y = get_node("Sprite/SpriteTop/BulletSource").global_position.y



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

func _on_Area2D_mouse_entered():
	$Sprite.modulate = Color(1, 1, 1, hover_alpha) # blue shade
	draw_attack_range = true
	update()

func _on_Area2D_mouse_exited():
	$Sprite.modulate = Color(1, 1, 1, 1) # blue shade
	draw_attack_range = false
	update()

func _on_Area2D_area_shape_entered(area_id, area, area_shape, local_shape):
	if(area.collision_layer == 2):
		targets.append(area)

func _on_Area2D_area_shape_exited(area_id, area, area_shape, local_shape):
	targets.erase(area)
