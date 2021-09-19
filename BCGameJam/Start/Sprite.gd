extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# get the height : width ratio of the texture
	var height: float = texture.get_height()
	var width: float = texture.get_width()
	var texture_ratio: float = height / width
	
	# get the height : width ratio of the view_port
	var view_port_height : float = ProjectSettings.get_setting("display/window/size/height")
	var view_port_width : float = ProjectSettings.get_setting("display/window/size/width")
	var view_port_ratio: float = view_port_height / view_port_width
	
	# if the texture ratio is larger than view port ratio, then the height of the texture is the largest
	# if it's smaller, then the width of the texture is the largest
	var texture_ratio_is_larger : bool = texture_ratio > view_port_ratio
	
	# if the texture ratio is larger, scale the texture ratio by its height
	# if the texture ratio is smaller, scale the texture ratio by its width
	# the ratio between the new length and the old length
	var new_ratio: float
	if texture_ratio_is_larger:
		var new_height : float = view_port_height
		new_ratio = new_height / height
		scale_size(new_ratio)
	else:
		var new_width : float = view_port_width
		new_ratio = new_width / width
		scale_size(new_ratio)

# scale the size of the current width and height of the sprite
func scale_size(scale: float) -> void:
	set_scale(Vector2(scale, scale))
