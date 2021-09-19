extends Area2D

signal death

# Health
var health = 1

# Movement
export var speed := 250
export var enemy_damage := 1
var path_node_name := "Path"
var points_in_path = null
var path_index := 0

# Facing direction
var curr_direction := 1 # Facing the right
var direction_change_count := 0
var direction_change_threshold := 10

var starting_z_index = null

var is_dead = false
func _ready():
	get_Points_in_path()
	starting_z_index = z_index

func get_Points_in_path():
	var path_node = get_tree().get_current_scene().get_node(path_node_name)
	points_in_path = path_node.points
	
func _process(delta):
	var next_point = get_next_point_in_path()
	move_towards_point_with_delta(next_point, delta)
	set_correct_direction(next_point)
	set_z_index(next_point)

func get_next_point_in_path():
	var next_point = points_in_path[path_index]
	
	# If we have reached the point, try move to the next point
	while(position.distance_to(next_point) < 1):
		path_index += 1
		next_point = points_in_path[path_index]
		
	# TODO: Handle logic for when we reach the end of the points list
	return next_point
	
func move_towards_point_with_delta(point: Vector2, delta):
	var velocity = (point - position).normalized() * speed
	var next_position = position + (velocity * delta);
	
	# If our speed is too big, we may pass the point in one movement step. If so, just travel to the point instead
	if(next_position.distance_to(point) > position.distance_to(point)):
		position = point
	else:
		position = next_position

func set_correct_direction(next_point: Vector2):
	var next_direction = 0
	if next_point.x >= position.x:
		next_direction = 1
	else:
		next_direction = -1
	
	if next_direction != curr_direction:
		direction_change_count += 1
		if direction_change_count >= direction_change_threshold:
			# Flip horizontal
			scale.x *= -1
			curr_direction = next_direction
			
			direction_change_count = 0

func set_z_index(next_point):
	# Reverse z index if walking upwards
	# This will ensure an enemies foot does not cover someone's face
	if next_point.y >= position.y:
		z_index = starting_z_index * -1
	else:
		z_index = starting_z_index

func _on_VisibilityNotifier2D_screen_exited():
	if is_dead: return
	handle_off_screen()

func handle_off_screen():
	# Decrease player health if the enemies get offscreen
	GlobalVars.player_health -= enemy_damage
	# If this causes the player to drop to 0 health, end the game
	if GlobalVars.player_health <= 0:
		get_tree().change_scene("res://GameOver/GameOver.tscn")
	print("DEBUG: Enemy off screen")
	handle_death()
	
func handle_hit():
	health -= 1
	if health < 1:
		handle_death()
	
func handle_death():
	is_dead = true
	emit_signal("death")
	queue_free()	# Delete enemy

func _on_Enemy_body_shape_entered(body_id, body, body_shape, local_shape):
	body.queue_free()
	handle_hit()
