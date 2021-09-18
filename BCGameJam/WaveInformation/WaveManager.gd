extends Panel

var enemy_scene = preload("res://Enemy/Enemy.tscn")
var wave_count = 0;
var enemy_count = 0;
var num_enemies_to_spawn = 5;
var spawn_button_name = "SpawnButton"

onready var enemy_count_label = get_node("EnemyCount")
onready var wave_count_label = get_node("WaveCount")
onready var timer_label = get_node("Timer")
onready var wave_start_timer = get_node("WaveInformationUI/WaveStartTimer")
var wave_start_time = 10
var is_wave_active

func _process(delta):
	enemy_count_label.text = str(num_enemies_to_spawn + enemy_count)
	wave_count_label.text = str(wave_count)
	timer_label.text = str(wave_start_timer.get_time_left())

func _on_SpawnButton_pressed():
	spawn_enemy()
	
func _on_WaveStartTimer_timeout():
	startNextWave()
	
func startNextWave():
	is_wave_active = true

func handleWaveEnd():
	is_wave_active = false
	wave_count += 1
	num_enemies_to_spawn = 10 + 5 * wave_count
	wave_start_timer.start(wave_start_time)
	
func _on_EnemySpawnTimer_timeout():
	print("hello")
	if(not is_wave_active): return
	
	if(num_enemies_to_spawn > 0):
		num_enemies_to_spawn -= 1
		spawn_enemy()

func spawn_enemy():
	enemy_count += 1
	
	var enemy_start_positon = Vector2(0, 0)
	var enemy = enemy_scene.instance()
	get_tree().get_current_scene().add_child(enemy)
	enemy.position = enemy_start_positon
	enemy.connect("death", self, "_on_Enemy_death")

func _on_Enemy_death():
	enemy_count -= 1
	
	if(num_enemies_to_spawn + enemy_count <= 0):
		handleWaveEnd()
