extends CanvasLayer
# Keeps various info on the screen updated.

#onready var portal = get_node("Portal")
onready var health_label = get_node("Health")
onready var money_label = get_node("Money")

func _process(delta):
	#portal.rotation = wrapf(rotation - delta, 0.0, 2.0 * PI)
	health_label.text = "Lives: " + str(GlobalVars.player_health)
	money_label.text = "Money: " + str(GlobalVars.player_money)
