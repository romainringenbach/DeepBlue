extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var left_click_pressed = false
var last_position

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func change_speed(delta):
	$Cylinder_001.rotate_x(-delta.y * 0.01)


func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			last_position = event.position
			left_click_pressed = true
	if event is InputEventMouseMotion and left_click_pressed:
		_change_speed(event.position - last_position)
		last_position = event.position
	elif event is InputEventMouseButton:
		if event.pressed == false and event.button_index == 1:
			left_click_pressed = false

func _on_StaticBody2_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseMotion and left_click_pressed:
		_change_speed(event.position - last_position)
		last_position = event.position
	elif event is InputEventMouseButton:
		if event.pressed == false and event.button_index == 1:
			left_click_pressed = false

func _on_StaticBody2_mouse_exited():
	left_click_pressed = false
