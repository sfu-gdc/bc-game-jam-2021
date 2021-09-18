class_name Clickable
extends Node2D

# the signal gets emitted whenever the player left clicks on an area
signal left_clicked_on_area
# is the mouse on the area or not, change this value from area2D signals
var mouse_on_area : bool = false
# defines other conditions that are needed for clicking on the objects
var other_click_condition_true : bool = true


# check if the user is left clicking on the area
func _input(event):
	# if the mouse is on area, and input gets an mouse action,
	# and the action is the left mouse button, and the left button is pressed
	# emit the signal left_clicked_on_area
	if mouse_on_area and event is InputEventMouseButton \
			and event.button_index == BUTTON_LEFT and event.is_pressed() \
			and other_click_condition_true:
		emit_signal("left_clicked_on_area")


# the function runs when the area enters the node, mouse on area set to true
func _area_entered():
	mouse_on_area = true


# function runs  when the area exits the node, mouse on area set to false
func _area_exited():
	mouse_on_area = false
