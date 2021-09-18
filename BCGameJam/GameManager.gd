extends Node

var SimpleTowerCard : PackedScene = preload("res://Card/SimpleTowerCard/SimpleTowerCard.tscn")

onready var GameScene : Node = get_node("/root/Main")


# Called when the node enters the scene tree for the first time.
func _ready():
	var tower_card = SimpleTowerCard.instance()
	GameScene.add_child(tower_card)
	tower_card.global_position.x = 500
	tower_card.global_position.y = 250


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
