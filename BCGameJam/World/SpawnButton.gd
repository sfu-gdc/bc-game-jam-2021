extends Button

var enemy_scene = preload("res://Enemy/Enemy.tscn")

func _on_Button_pressed():
	var enemy_start_positon = Vector2(0, 0)
	var enemy = enemy_scene.instance()
	get_tree().get_current_scene().add_child(enemy)
	enemy.position = enemy_start_positon
