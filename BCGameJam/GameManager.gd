extends Node

var SimpleBullet : PackedScene = preload("res://Bullets/SimpleBullet/SimpleBullet.tscn")
var SimpleTower : PackedScene = preload("res://Tower/SimpleTower/SimpleTower.tscn")

onready var GameScene : Node = get_node("/root/Main")


# Called when the node enters the scene tree for the first time.
func _ready():
	var tower = SimpleTower.instance()
	GameScene.add_child(tower)
	tower.global_position.x = 500
	tower.global_position.y = 250


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
