extends Panel

var enemy_scene = preload("res://Enemy/Enemy.tscn")
var wave_count = 0;
var enemy_count = 0;
var num_enemies_to_spawn = 0;

func _ready():
	pass 

func _process(delta):
	pass

func _on_EnemySpawnTimer_timeout():
	if(num_enemies_to_spawn > 0):
		spawn_enemy()
		num_enemies_to_spawn -= 1

func spawn_enemy():
	var enemy_start_positon = Vector2(0, 0)
	var enemy = enemy_scene.instance()
	get_tree().get_current_scene().add_child(enemy)
	enemy.position = enemy_start_positon
