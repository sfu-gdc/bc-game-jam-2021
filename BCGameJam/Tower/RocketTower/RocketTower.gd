extends Tower


const aim_speed = deg2rad(90)
onready var sprite_top: Sprite = get_node("Sprite/SpriteTop")
const scale_y : float = 1.0
const scale_negative_y : float = -1.0
var placing_time : float = 0.0
var is_area_entered : bool = false


func _process(delta):
	var mouse_position = get_global_mouse_position()
	if sprite_top.get_angle_to(mouse_position) > 0:
		sprite_top.rotation += aim_speed * delta
	else:
		sprite_top.rotation -= aim_speed * delta
	if fmod(sprite_top.rotation + PI / 2, 2 * PI) < PI and fmod(sprite_top.rotation + PI / 2, 2 * PI) > 0:
		sprite_top.scale.y = scale_y
	elif fmod(sprite_top.rotation - PI / 2, 2 * PI) < 0 and fmod(sprite_top.rotation - PI / 2, 2 * PI) > -PI:
		sprite_top.scale.y = scale_y
	else:
		sprite_top.scale.y = scale_negative_y
	
	print(fmod(sprite_top.rotation - PI / 2 , 2 * PI))
	if placing_time > 0.1 and not is_area_entered:
		get_node("Sprite/Area").disconnect("area_entered", self, "_on_Area_area_entered")
		is_area_entered = true
	
	placing_time += delta


func set_status(stats):
	print(stats)
	size_radius = stats["rocket_tower"]["radius"]
	attack_range = stats["rocket_tower"]["range"]
	attack_cool_down = stats["rocket_tower"]["cool_down"]
	attack_dmg = stats["rocket_tower"]["dmg"]
	cost = stats["rocket_tower"]["cost"]
	bullet = preload("res://Bullets/Missle/Missle.tscn")




func _on_Area_area_entered(area):
	queue_free()


func _on_Area_mouse_entered():
	pass # Replace with function body.


func _on_Area_mouse_exited():
	pass # Replace with function body.


func _on_Area2_area_shape_entered(area_id, area, area_shape, local_shape):
	pass # Replace with function body.


func _on_Area2_area_shape_exited(area_id, area, area_shape, local_shape):
	pass # Replace with function body.


func _on_Area2_mouse_entered():
	pass # Replace with function body.


func _on_Area2_mouse_exited():
	pass # Replace with function body.
