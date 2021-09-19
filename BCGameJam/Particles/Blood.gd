extends CPUParticles2D

var animate_fade = false
func _on_FreezeBlood_timeout():
	# Freeze the blood particles
	# https://www.youtube.com/watch?v=2iJWSd6jouE&list=PL6bQeQE-ybqAYoaWz_ZEE2X4wX6PhwCWR&index=5
	set_process(false)
	set_physics_process(false)
	set_process_input(false)
	set_process_internal(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)
