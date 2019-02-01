extends StaticBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal left_click()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			emit_signal("left_click")
