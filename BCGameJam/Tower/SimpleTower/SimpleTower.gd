extends Tower


func set_status(stats):
	print(stats)
	size_radius = stats["simple_tower"]["radius"]
	attack_range = stats["simple_tower"]["range"]
	attack_cool_down = stats["simple_tower"]["cool_down"]
	attack_dmg = stats["simple_tower"]["dmg"]
