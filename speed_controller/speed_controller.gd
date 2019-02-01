extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal position_changed(percent)

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
	if $Cylinder_001.rotation_degrees.x  + delta.y>= -15 and $Cylinder_001.rotation_degrees.x  + delta.y <= 78:
		$Cylinder_001.rotate_x(delta.y * 0.01)
		
		var percent = 1-($Cylinder_001.rotation_degrees.x+15)/(78+15)
		if percent < 0.1:
			percent = 0.0
		if percent > 0.9:
			percent = 1.0
		
		emit_signal("position_changed", percent)
	


func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			last_position = event.position
			left_click_pressed = true
		elif event.pressed == false and event.button_index == 1:
			left_click_pressed = false
	elif event is InputEventMouseMotion and left_click_pressed:
		change_speed(event.position - last_position)
		last_position = event.position
		

func _on_StaticBody_mouse_exited():
	left_click_pressed = false
