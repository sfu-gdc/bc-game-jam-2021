extends Area2D

export var speed = 500
var path_node_name = "Path"
var points_in_path = null
var path_index = 0

func _ready():
	get_Points_in_path()

func get_Points_in_path():
	var path_node = get_tree().get_current_scene().get_node(path_node_name)
	points_in_path = path_node.points
	
func _process(delta):
	var next_point = get_next_point_in_path()
	move_towards_point_with_delta(next_point, delta)

func get_next_point_in_path():
	var next_point = points_in_path[path_index]
	
	# If we have reached the point, try move to the next point
	while(position.distance_to(next_point) < 1):
		path_index += 1
		next_point = points_in_path[path_index]
		
	# TODO: Handle logic for when we reach the end of the points list
	return next_point
	
func move_towards_point_with_delta(point, delta):
	var velocity = (point - position).normalized() * speed
	var next_position = position + (velocity * delta);
	
	# If our speed is too big, we may pass the point in one movement step. If so, just travel to the point instead
	if(next_position.distance_to(point) > position.distance_to(point)):
		position = point
	else:
		position = next_position

func _on_VisibilityNotifier2D_screen_exited():
	handle_enemy_off_screen()

func handle_enemy_off_screen():
	# TODO: Lower player health
	print("DEBUG: Enemy off screen")
	queue_free()	# Delete enemy
