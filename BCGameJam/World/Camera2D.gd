extends Camera2D

var background
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	background = get_node("/root/World/Background")
	background.position = Vector2(-0.5 * background.scale.x, -0.5 * background.scale.y)

func _process(delta):
<<<<<<< Updated upstream
	zoom += 0.02 * zoom.x * Vector2(delta, delta)
=======
	zoom += 0.05 * zoom.x * Vector2(delta, delta)
	background.scale = Vector2(screen_size.x * zoom.x, screen_size.y * zoom.y)
	background.position = Vector2(-0.5 * background.position.x, -0.5 * background.position.y)
>>>>>>> Stashed changes
