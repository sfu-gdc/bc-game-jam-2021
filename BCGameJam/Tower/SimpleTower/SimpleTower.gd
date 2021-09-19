extends Tower

const aim_speed = deg2rad(180)
onready var sprite_top: Sprite = get_node("Sprite/SpriteTop")
const scale_y : float = 1.611
const scale_negative_y : float = -1.611


func _process(delta):
	if target == null: return
	
	if sprite_top.get_angle_to(target.position) > 0:
		sprite_top.rotation += aim_speed * delta
	else:
		sprite_top.rotation -= aim_speed * delta
	if fmod(sprite_top.rotation + PI / 2 , 2 * PI) > PI:
		sprite_top.scale.y = scale_negative_y
		
	else:
		sprite_top.scale.y = scale_y


func set_status(stats):
	print(stats)
	size_radius = stats["simple_tower"]["radius"]
	attack_range = stats["simple_tower"]["range"]
	attack_cool_down = stats["simple_tower"]["cool_down"]
	attack_dmg = stats["simple_tower"]["dmg"]
