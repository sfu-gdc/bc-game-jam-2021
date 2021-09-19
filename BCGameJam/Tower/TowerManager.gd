class_name TowerManager
extends Node

var tower_stats = {
	"simple_tower": {
		"radius": 50,
		"range": 300,
		"cool_down": 0.75,
		"dmg": 10
	},
	"rocket_tower": {
		"radius": 50,
		"range": 300,
		"cool_down": 1,
		"dmg": 10
	}
}

var SimpleTowerCard : PackedScene = preload("res://Card/SimpleTowerCard/SimpleTowerCard.tscn")
var RocketTowerCard : PackedScene = preload("res://Card/RocketTowerCard/RocketTowerCard.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	instance_simple_tower_card()

# instance the simple tower card
func instance_simple_tower_card():
	var tower_card = SimpleTowerCard.instance()
	tower_card._set_card_moving_mechanmic(tower_stats["simple_tower"]["radius"])
	tower_card.stats = tower_stats
	get_node("../CanvasLayer").add_child(tower_card)
	
	# change to screen coordiantes instead of world (figure it out)
	tower_card.global_position.x = 700
	tower_card.global_position.y = 30
	
	var rocket_tower_card = RocketTowerCard.instance()
	rocket_tower_card._set_card_moving_mechanmic(tower_stats["rocket_tower"]["radius"])
	rocket_tower_card.stats = tower_stats
	get_node("../CanvasLayer").add_child(rocket_tower_card)
	
	rocket_tower_card.global_position.x = 750
	rocket_tower_card.global_position.y = 30
	

# set the size of the sprite to a new width
func _set_size(sprite_node: Sprite, new_width: float) -> void:
	var width : float = sprite_node.get_texture().get_width()
	var new_ratio = new_width / width
	_scale_size(sprite_node, new_ratio)

# scale the sprite, for internal use
func _scale_size(sprite_node: Sprite, scale: float) -> void:
	sprite_node.set_scale(Vector2(scale, scale));
