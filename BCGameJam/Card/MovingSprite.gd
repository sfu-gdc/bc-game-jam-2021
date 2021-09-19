# the moving sprite appears when the user clicks on a card
# the class will have its own click functions, but it will be different
class_name MovingSprite
extends Sprite

# emit this signal when the user clicks again
signal sprite_clicked

var scene_class
var level_path
var texture_size_radius: int
var stats
var card


func _init(image_texture, _scene_class, _stats, path, _texture_size_radius: int, _card):
	# instantiate all the variables
	texture = image_texture
	scene_class = _scene_class
	stats = _stats
	level_path = path
	texture_size_radius = _texture_size_radius
	card = _card
	connect("sprite_clicked", card, "clicked_sprite")
	
	if scene_class == null:
		print("In moving sprite, item is null, card returns a null object")


# Called when the node enters the scene tree for the first time.
func _ready():
	# set the texture to be half transparent
	set_modulate(Color(0.75, 0.75, 0.75, 0.75))
	# set the scale of the texture
	var width = 2 * texture_size_radius
	_set_size(self, width)


func _input(event):
	# if the mouse is moving, set the global position of the sprite to be the mouse position
	if event is InputEventMouseMotion:
		global_position = get_global_mouse_position()
	# if the sprite is left clicked, emit signals meaning sprite has been clicked
	# add a new object in the level node
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT \
			and event.is_pressed():
		emit_signal("sprite_clicked")
		if not card.mouse_on_area:
			_add_object()


func _add_object():
	var scene_instance = scene_class.instance()
	scene_instance.set_status(stats)
	level_path.add_child(scene_instance)
	scene_instance.global_position = get_global_mouse_position()


func _set_size(sprite_node: Sprite, new_width: float) -> void:
	var width : float = sprite_node.get_texture().get_width()
	var new_ratio = new_width / width
	_scale_size(sprite_node, new_ratio)


func _scale_size(sprite_node: Sprite, scale: float) -> void:
	sprite_node.set_scale(Vector2(scale, scale));
