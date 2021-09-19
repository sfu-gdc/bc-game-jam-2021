extends Area2D

signal death


const HEALTH_SCALE := 0.5
const SPEED_SCALE := 100.0
const SIZ_SCALE := 0.75


# Health
export var max_health = 10
var health = max_health

# Movement
export var speed := 200

var path_node_name := "Path"
var points_in_path = null
var path_index := 0

# Facing direction
var curr_direction := 1 # Facing the right
var direction_change_count := 0
var direction_change_threshold := 10

var starting_z_index = null
var blood_particles = preload("res://Particles/Blood.tscn")

func update_health_bar():
	get_node("HealthBar/ProgressBar").value = health
	get_node("HealthBar/Label").text = str(health)

var is_dead = false
func _ready():
	get_Points_in_path()
	starting_z_index = z_index
	
	# Scale enemy based on world scale
	health = ceil(HEALTH_SCALE * (GlobalVars.current_wave + 1))
  max_health = health
	speed = floor(SPEED_SCALE * GlobalVars.world_scale)
	$Body.scale *= max(SIZ_SCALE + 0.25 * GlobalVars.current_wave, SIZ_SCALE * GlobalVars.wave_size)
	var collision_shape = $CollisionShape2D
	collision_shape.shape.extents *= max(SIZ_SCALE + 0.25 * GlobalVars.current_wave, SIZ_SCALE * GlobalVars.wave_size)
	collision_shape.position *= max(SIZ_SCALE + 0.25 * GlobalVars.current_wave, SIZ_SCALE * GlobalVars.wave_size)
	print(max(SIZ_SCALE + 0.25 * GlobalVars.current_wave, SIZ_SCALE * GlobalVars.wave_size))

	get_node("HealthBar/ProgressBar").max_value = max_health
	update_health_bar()

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
			get_node("HealthBar").scale.x *= -1 # the health bar should remain facing the right way
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
	GlobalVars.player_health -= health
	# If this causes the player to drop to 0 health, end the game
	if GlobalVars.player_health <= 0:
		get_tree().change_scene("res://GameOver/GameOver.tscn")
	print("DEBUG: Enemy off screen")
	handle_death()
	
func handle_hit(body):
	health -= 1
	update_health_bar()
	if health < 1:
		GlobalVars.player_money += max_health
		handle_death()
		emit_blood()

func emit_blood():
	var blood = blood_particles.instance()
	blood.global_position = global_position
	get_tree().get_current_scene().add_child(blood)

func handle_death():
	is_dead = true
	print(health)
	emit_signal("death")
	queue_free()	# Delete enemy

func _on_Enemy_body_shape_entered(body_id, body, body_shape, local_shape):
	body.queue_free()
	handle_hit(body)
