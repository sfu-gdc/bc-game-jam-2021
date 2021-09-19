extends Sprite
# Script to make the portal spin

func _process(delta):
	rotation = wrapf(rotation - delta, 0.0, 2.0 * PI)
