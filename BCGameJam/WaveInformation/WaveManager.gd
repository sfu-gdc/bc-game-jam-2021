extends Panel

var enemy_scene = preload("res://Enemy/Enemy.tscn")
var wave_count = 0;
var enemy_count = 0;
var num_enemies_to_spawn = 0;
var spawn_button_name = "SpawnButton"

func _ready():
	pass

func _process(delta):
	get_node("EnemyCount").text = str(enemy_count)

func _on_EnemySpawnTimer_timeout():
	if(num_enemies_to_spawn > 0):
		num_enemies_to_spawn -= 1
		spawn_enemy()

func _on_SpawnButton_pressed():
	spawn_enemy()

func _on_Enemy_death():
	enemy_count -= 1
	
func spawn_enemy():
	enemy_count += 1
	
	var enemy_start_positon = Vector2(0, 0)
	var enemy = enemy_scene.instance()
	get_tree().get_current_scene().add_child(enemy)
	enemy.position = enemy_start_positon
	enemy.connect("death", self, "_on_Enemy_death")
