extends Spatial

export (float) var cam_speed = 3
export (float) var zoom_speed = 2
export (float) var move_speed = 8
	
func _process(delta):
	if Input.is_action_pressed("forward"):
		self.translate(Vector3(0,0,-move_speed) * delta)
	if Input.is_action_pressed("backward"):
		self.translate(Vector3(0,0,move_speed) * delta)
	if Input.is_action_pressed("StrafeLeft"):
		self.translate(Vector3(-move_speed,0,0) * delta)
	if Input.is_action_pressed("StrafeRight"):
		self.translate(Vector3(move_speed,0,0) * delta)
		
	if Input.is_action_pressed("Ascend"):
		self.translate(Vector3(0,move_speed,0) * delta)
	if Input.is_action_pressed("Descend"):
		self.translate(Vector3(0,-move_speed,0) * delta)
	
	if Input.is_action_pressed("ui_left"):
		self.rotate_y(cam_speed * delta)
	if Input.is_action_pressed("ui_right"):
		self.rotate_y(-cam_speed * delta)
	if Input.is_action_pressed("ui_up"):
		get_node("CamPitch").rotate_x(-cam_speed * delta)
	if Input.is_action_pressed("ui_down"):
		get_node("CamPitch").rotate_x(cam_speed * delta)
	if Input.is_action_pressed("ui_page_up"):
		get_node("CamPitch/Camera").translate(Vector3(0,0,zoom_speed) * delta)
	if Input.is_action_pressed("ui_page_down"):
		get_node("CamPitch/Camera").translate(Vector3(0,0,-zoom_speed) * delta)
