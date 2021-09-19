extends Card


func _set_card_moving_mechanmic(_texture_size_radius):
	image_texture = load("res://Assets/Turret/Turret.png")
	scene_class = load("res://Tower/SimpleTower/SimpleTower.tscn")
	texture_size_radius = _texture_size_radius
