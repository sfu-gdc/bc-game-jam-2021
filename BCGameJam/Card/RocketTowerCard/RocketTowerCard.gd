extends Card


func _set_card_moving_mechanmic(_texture_size_radius):
	image_texture = load("res://Assets/Turret/RocketTower.png")
	scene_class = load("res://Tower/RocketTower/RocketTower.tscn")
	texture_size_radius = _texture_size_radius
