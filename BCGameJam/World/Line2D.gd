extends Line2D

# Maybe just check that the line doesn't intersect itself, instead of doing all that wacky code stuff. 


func _ready():
	var jump_radius = 1.0
	var current_radius = 0.0
	var current_angle = 0.0
	
	randomize()
	
	for index in 2000:
		add_point(polar2cartesian(
				index * jump_radius, 
				rand_range(
						current_angle - acos(current_radius / (current_radius + jump_radius)), 
						current_angle + acos(current_radius / (current_radius + jump_radius))
						)
				))
		jump_radius += 0.1
		current_radius += jump_radius
		current_angle = atan2(points[points.size() - 1].y, points[points.size() - 1].x)


func _process(_delta):
	width = 10.0 * $"../Camera2D".zoom.x
