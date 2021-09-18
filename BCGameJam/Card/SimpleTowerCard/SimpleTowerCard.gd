extends Card


var tower


# Called when the node enters the scene tree for the first time.
func _ready():
	image_texture = load("res://Assets/elephant.png")
	scene_class = load("res://Tower/SimpleTower/SimpleTower.tscn")
	texture_scale = 0.25


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
