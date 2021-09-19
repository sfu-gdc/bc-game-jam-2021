extends Label

func _process(_delta):
	text = "Wave " + str(GlobalVars.current_wave + 1)
