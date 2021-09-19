extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_Button_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://World/World.tscn") # Actually starts the game.

