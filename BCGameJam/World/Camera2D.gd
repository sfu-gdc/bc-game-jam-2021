extends Camera2D

var background
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	zoom += 0.01 * zoom.x * Vector2(delta, delta)
	GlobalVars.world_scale = zoom.x
