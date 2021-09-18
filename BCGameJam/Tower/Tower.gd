class_name Tower
extends Node2D


export(float) var size_radius : float
export(float) var attack_range : float
export(float) var attack_cool_down : float
export(float) var attack_dmg : float

var size_counter : float = 1.0
# the time it takes to scale the 
const scale_second : float = 10.0
var front : Texture = preload("res://Assets/giraffe.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.texture = front


func _process(delta):
	_scale_size(size_counter)
	size_counter -= delta / scale_second


func _scale_size(scale: float) -> void:
	$Sprite.set_scale(Vector2(scale, scale));
