extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().change_scene("res://Start/Start.tscn") # Immediately goes to the start menu.
