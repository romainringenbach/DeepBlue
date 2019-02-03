extends InterpolatedCamera

onready var Yaw = get_parent()

export (float) var MAX_ZOOM = 20 
export (float) var MAX_UNZOOM = 55
export (float) var pas = 5

func _ready():
	## Tell Godot that we want to handle input
	#set_process_input(true)
	pass
	
func look_updown_rotation(rotation = 0):
	"""
	Get the new rotation for looking up and down
	"""
	var r_rotation = self.get_rotation() + Vector3(rotation, 0, 0)
	if r_rotation.x < -90:
		r_rotation.x = -90
	if r_rotation.x > 90:
		r_rotation.x = 90

	##
	## We don't want the player to be able to bend over backwards
	## neither to be able to look under their arse.
	## Here we'll clamp the vertical look to 90° up and down
	r_rotation.x = clamp(r_rotation.x, PI / -2, PI / 2)

	return r_rotation

func look_leftright_rotation(rotation = 0):
	"""
	Get the new rotation for looking left and right
	"""
	var r_rotation = Yaw.get_rotation() + Vector3(0, rotation, 0)
	
	if r_rotation.y < -1.4:
		r_rotation.y = -1.4
		#print("merde")
	if r_rotation.y > 1.4:
		r_rotation.y = 1.4
		#print("merde2")
	
	return r_rotation

func mouse(event):
	"""
	First person camera controls
	"""
	##
	## We'll use the parent node "Yaw" to set our left-right rotation
	## This prevents us from adding the x-rotation to the y-rotation
	## which would result in a kind of flight-simulator camera
	Yaw.set_rotation(look_leftright_rotation(event.relative.x / -200))

	##
	## Now we can simply set our y-rotation for the camera, and let godot
	## handle the transformation of both together
	self.set_rotation(look_updown_rotation(event.relative.y / -200))

func _input(event):
	##
	## We'll only process mouse motion events
	if event is InputEventMouseMotion and Input.is_action_pressed("right_click"):
		return mouse(event)
		
	if Input.is_action_pressed("zoom"):
		fov -= pas
		if fov < MAX_ZOOM:
			fov = MAX_ZOOM
	if Input.is_action_pressed("unzoom"):
		fov += pas
		if fov > MAX_UNZOOM:
			fov = MAX_UNZOOM

func _enter_tree():
	"""
	Hide the mouse when we start
	"""
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _leave_tree():
	"""
	Show the mouse when we leave
	"""
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass