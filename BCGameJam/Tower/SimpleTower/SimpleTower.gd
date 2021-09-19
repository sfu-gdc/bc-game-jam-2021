extends Tower

const aim_speed = deg2rad(180)
onready var sprite_top: Sprite = get_node("Sprite/SpriteTop")
const scale_y : float = 1.611
const scale_negative_y : float = -1.611
var placing_time : float = 0.0
var is_area_entered : bool = false


func _process(delta):
	if targets.size() <= 0: return
	
	var target = targets[0]
	if sprite_top.get_angle_to(target.position) > 0:
		sprite_top.rotation += aim_speed * delta
	else:
		sprite_top.rotation -= aim_speed * delta
	if fmod(sprite_top.rotation + PI / 2, 2 * PI) < PI and fmod(sprite_top.rotation + PI / 2, 2 * PI) > 0:
		sprite_top.scale.y = scale_y
	elif fmod(sprite_top.rotation - PI / 2, 2 * PI) < 0 and fmod(sprite_top.rotation - PI / 2, 2 * PI) > -PI:
		sprite_top.scale.y = scale_y
	else:
		sprite_top.scale.y = scale_negative_y
		
	if placing_time > 0.1 and not is_area_entered:
		get_node("Sprite/Area2D2").disconnect("area_entered", self, "_on_Area_area_entered")
		is_area_entered = true
	
	placing_time += delta


func set_status(stats):
	size_radius = stats["simple_tower"]["radius"]
	attack_range = stats["simple_tower"]["range"]
	attack_cool_down = stats["simple_tower"]["cool_down"]
	attack_dmg = stats["simple_tower"]["dmg"]


func _on_Area_area_entered(area):
	queue_free()
