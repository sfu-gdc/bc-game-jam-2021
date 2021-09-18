extends Line2D
# A script to generate the infinite path


# Maybe just check that the line doesn't intersect itself, instead of doing all that wacky code stuff. 
const JUMP_RAD_RATE := 40.0


var jump_radius := 10.0
var current_radius := 10.0
var current_angle := 0.0


onready var camera := $"../Camera2D"


# A function that returns an array of points leading from prev_point to next_point_polar
func path_split(prev_point: Vector2, next_point_polar: Vector2) -> Array:
	# Get the previous point in polar coords
	var prev_point_polar = cartesian2polar(prev_point.x, prev_point.y)
	# Put the next point as a polar coord into the split_points array
	var split_points = [next_point_polar]
	
	# While the line from prev_point to the first dot in the split_point array intersects the circle of radius prev_point
	while Geometry.segment_intersects_circle(prev_point + 10.0 * prev_point.normalized(), polar2cartesian(split_points[0].x, split_points[0].y), Vector2(), prev_point_polar.x) != -1:
		
		# Create a new array to store points in
		var new_points := []
		# For each point in the split_points array, add a new point to new_points with half the angle between its current angle and the previous point's angle
		for index in split_points.size():
			if index == 0:
				var angle_to_next := prev_point.angle_to(polar2cartesian(split_points[index].x, split_points[index].y))
				new_points.append(Vector2(split_points[index].x, prev_point_polar.y + (angle_to_next / 2.0)))
			else:
				var angle_to_next := polar2cartesian(split_points[index - 1].x, split_points[index - 1].y).angle_to(polar2cartesian(split_points[index].x, split_points[index].y))
				new_points.append(Vector2(split_points[index].x, split_points[index - 1].y + (angle_to_next / 2.0)))
		# The add the point itself back in
			new_points.append(split_points[index])
		# Set the split_points to the new_points we just made
		split_points = new_points
	
	# Convert all the split_points into cartesian coords
	for index in split_points.size():
		split_points[index] = polar2cartesian(split_points[index].x, split_points[index].y)
	
	# Return the cartesian coords
	return split_points


# Generates the next points along the path
func generate_path_point() -> void:
	# Increase the radius by the current jump, and increase jump radius
	current_radius = points.size() * jump_radius
	
	# Find the next point for the path to jump to
	var next_jump := Vector2(
			current_radius, 
			rand_range(-PI, PI)
			)
	
	# Figure out the best path to get to that point
	for point in path_split(points[points.size() - 1], next_jump):
		add_point(point)


func _ready():
	randomize()
	
	add_point(Vector2())
	add_point(Vector2(10.0, 0.0))


func _process(_delta):
	# Grow everything
	width = 10.0 * camera.zoom.x
	jump_radius = JUMP_RAD_RATE * camera.zoom.x
	
	# Generate new points
	while current_radius < 2.0 * camera.zoom.x * get_viewport().size.x:
		generate_path_point()
	
	# Delete any points under the portal
	var new_points := []
	var assign := false
	for index in points.size() - 1:
		if points[index + 1].length_squared() > 5625.0 * camera.zoom.x or points[index] == Vector2():
			new_points.append(points[index])
		else:
			assign = true
	if assign:
		points = new_points
	
	print(points.size())
