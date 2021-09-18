extends AnimationPlayer

var run_animation_name = "Run"

# Called when the node enters the scene tree for the first time.
func _ready():
	play(run_animation_name)
