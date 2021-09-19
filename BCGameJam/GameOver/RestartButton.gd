extends Button
# Button to restart game



func _on_RestartButton_button_up():
	GlobalVars.player_health = 10
	get_tree().change_scene("res://World/World.tscn")
