extends Camera2D

func _process(delta):
	zoom += 0.05 * zoom.x * Vector2(delta, delta)
