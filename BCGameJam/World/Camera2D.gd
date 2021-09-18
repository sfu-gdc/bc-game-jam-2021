extends Camera2D

func _process(delta):
	zoom += 0.1 * zoom.x * Vector2(delta, delta)
