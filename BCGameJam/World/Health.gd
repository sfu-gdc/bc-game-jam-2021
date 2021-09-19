extends Label
# Script to keep the lives counter updated

func _process(_delta):
	text = "Lives: " + str(GlobalVars.player_health)
