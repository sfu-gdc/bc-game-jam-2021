class_name Card
extends Clickable

var clicked : bool = false

export(Texture) var image_texture : Texture

var is_dragging : bool = false
var moving_sprite_class = preload("res://Card/MovingSprite.gd")
# scale the texture or not
var texture_size_radius : int
# scene class to be instanced and placed after clicking while dragging
var scene_class : PackedScene

var tower : Tower
# the moving sprite that will appear when the user clicks on the texture
var new_moving_sprite
# check if there's already a moving sprite
var _has_moving_sprite : bool = false
# stats of the tower
var stats


func _ready():
	connect("left_clicked_on_area", self, "_on_click")


func _on_click():
	var level_path = get_node("/root/World")
	# upon clicking on the card, the card turns dark if the card hasn't been clicked before
	if not clicked:
		_turn_dark()
		clicked = true
		
		new_moving_sprite = moving_sprite_class.new(image_texture, scene_class, stats, level_path, texture_size_radius, self)
		
		level_path.add_child(new_moving_sprite)
		new_moving_sprite.global_position = global_position
	# if the card is already clicked, turn card back to normal color, and delete the moving sprite instance
	elif clicked:
		if new_moving_sprite == null:
			print("Error! new_moving_sprite is null in Card")
		elif new_moving_sprite != null:
			new_moving_sprite.queue_free()
			new_moving_sprite = null
			clicked = false
			_turn_back()


func clicked_sprite():
	if not mouse_on_area:
		clicked = false
		_turn_back()
		new_moving_sprite.queue_free()
		new_moving_sprite = null


func _turn_dark():
	set_modulate(Color(0.5, 0.5, 0.5, 0.5))


func _turn_back():
	set_modulate(Color(1.0, 1.0, 1.0, 1.0))
