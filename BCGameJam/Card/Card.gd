class_name Card
extends Clickable

var clicked : bool = false

export(Texture) var image_texture : Texture

var is_dragging : bool = false
var moving_sprite_class = preload("res://Card/MovingSprite.gd")
# scale the texture or not
var texture_scale : int = 1
# scene class to be instanced and placed after clicking while dragging
var scene_class
# the moving sprite that will appear when the user clicks on the texture
var new_moving_sprite
# the scene of the tower
var tower_scene : PackedScene

onready var level_path = get_node("/root/Main")


func _ready():
	connect("left_clicked_on_area", self, "_on_click")


func _on_click():
	# upon clicking on the card, the card turns dark if the card hasn't been clicked before
	if not clicked:
		_turn_dark()
		clicked = true
		
		new_moving_sprite = moving_sprite_class.new(image_texture, scene_class, level_path, texture_scale)
		
		level_path.add_child(new_moving_sprite)
		new_moving_sprite.global_position = global_position
	# if the card is already clicked, turn card back to normal color, and delete the moving sprite instance
	elif clicked:
		if new_moving_sprite == null:
			print("Error! new_moving_sprite is null in Card")
		elif new_moving_sprite != null:
#			_create_new_tower(tower_scene)
			new_moving_sprite.queue_free()
			new_moving_sprite = null
			# reset the click
			clicked = false


#func _create_new_tower(scene: PackedScene):
#	var tower = scene.instance()
#	level_path.add_child(tower)


func _turn_dark():
	set_modulate(Color(0.5, 0.5, 0.5, 0.5))


func _turn_back():
	set_modulate(Color(1.0, 1.0, 1.0, 1.0))


func _set_size(sprite_node: Sprite, new_width: float) -> void:
	var width : float = sprite_node.get_texture().get_width()
	var new_ratio = new_width / width
	_scale_size(sprite_node, new_ratio)


func _scale_size(sprite_node: Sprite, scale: float) -> void:
	sprite_node.set_scale(Vector2(scale, scale));
