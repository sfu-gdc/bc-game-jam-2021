class_name TowerManager
extends Node

var tower_stats = {
	"simple_tower": {
		"radius": 50,
		"range": 300,
		"cool_down": 0.1,
		"dmg": 10
	}
}

var SimpleTowerCard : PackedScene = preload("res://Card/SimpleTowerCard/SimpleTowerCard.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	instance_simple_tower_card()

# instance the simple tower card
func instance_simple_tower_card():
	var tower_card = SimpleTowerCard.instance()
	tower_card._set_card_moving_mechanmic(tower_stats["simple_tower"]["radius"])
	tower_card.stats = tower_stats
	add_child(tower_card)
	
	# change to screen coordiantes instead of world (figure it out)
	tower_card.global_position.x = 500
	tower_card.global_position.y = 250

# set the size of the sprite to a new width
func _set_size(sprite_node: Sprite, new_width: float) -> void:
	var width : float = sprite_node.get_texture().get_width()
	var new_ratio = new_width / width
	_scale_size(sprite_node, new_ratio)

# scale the sprite, for internal use
func _scale_size(sprite_node: Sprite, scale: float) -> void:
	sprite_node.set_scale(Vector2(scale, scale));
