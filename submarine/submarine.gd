extends RigidBody

#export var TURN_SPEED = 7
#export var LOW_THRUST = 50
#export var MED_THRUST = 100
export var FULL_THRUST = 100
export var STEER_FORCE_LR = 1.5
export var STEER_FORCE_UD = 0.8

var current_speed = 0.0;

var impulse_left = false
var impulse_right = false
var impulse_up = false
var impulse_down = false

var fake_speed = 0.01

var player_direction = Vector3()

var echos = {}
var pos
var level
var value

var direction_changed = false

var collision = false
var shake = false

signal collision_impact()
signal shaky(force)

func _ready():
	player_direction = $Cockpit.get_global_transform().basis.z
	$Cockpit/Viewports/TopView/Yaw.target = get_path()
	$Cockpit/Viewports/BottomView/Yaw.target = get_path()
	

func get_input():
	
	player_direction = $Cockpit.get_global_transform().basis.z
	
	
	
	if Input.is_action_pressed("ui_left"):
		impulse_left = true
	if Input.is_action_just_released("ui_left"):
		impulse_left = false
		
	if Input.is_action_pressed("ui_right"):
		impulse_right = true
	if Input.is_action_just_released("ui_right"):
		impulse_right = false
	
	if Input.is_action_pressed("ui_up"):
		impulse_up = true
	if Input.is_action_just_released("ui_up"):
		impulse_up = false
	
	if Input.is_action_pressed("ui_down"):
		impulse_down = true
	if Input.is_action_just_released("ui_down"):
		impulse_down = false

func _process(delta):
	get_input()


func _integrate_forces(state):
	state.add_force(player_direction*current_speed, Vector3())
	if (impulse_left):
		state.apply_torque_impulse(Vector3(0,STEER_FORCE_LR,0))
	if (impulse_right):
		state.apply_torque_impulse(Vector3(0,-STEER_FORCE_LR,0))
	if (impulse_up):
		state.apply_torque_impulse(Vector3(-STEER_FORCE_UD,0,0))
	elif rotation.x < -0.1:
		state.apply_torque_impulse(Vector3(STEER_FORCE_UD/5,0,0))
		
	if (impulse_down):
		state.apply_torque_impulse(Vector3(STEER_FORCE_UD,0,0))
	elif rotation.x > 0.1:
		state.apply_torque_impulse(Vector3(-STEER_FORCE_UD/5,0,0))
		
	if rotation.z < -0.1:
		state.apply_torque_impulse(Vector3(0,0,STEER_FORCE_UD/5))
	if rotation.z > 0.1:
		state.apply_torque_impulse(Vector3(0,0,-STEER_FORCE_UD/5))
		
	state.integrate_forces()
	
	var final_force = state.get_linear_velocity() / state.get_inverse_mass() /state.step

	var deviation = 0

	if final_force.length() != 0 and (player_direction*current_speed).length() != 0:

		var s = current_speed
		if s == 0:
			s = fake_speed


		deviation = acos(final_force.dot(player_direction*current_speed)/(final_force.length()*(player_direction*s).length()))
	
		if ((deviation != 0 and abs(deviation * final_force.length()) > 10000) or (final_force.length() < 0.5 and current_speed != 0) ) and $Area2.get_overlapping_bodies().size() > 1 and collision == false:
			emit_signal('collision_impact')
			collision = true
			
			
		elif collision == true and (abs(deviation * final_force.length()) <= 8000 or $Area2.get_overlapping_bodies().size() == 1):
			collision = false

		print (abs(deviation * final_force.length()))


func _on_Cockpit_speed_changed(speed_percent):
	
	current_speed = FULL_THRUST*speed_percent
	if current_speed < 0:
		fake_speed = -1
	elif current_speed > 0:
		fake_speed = 1


func _on_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	echos[body_id] = {'body':body,'body_shape':body_shape,'area_shape':area_shape,'old_body_position':body.global_transform.origin}
	for child in body.get_children():
		if child is VisualInstance:
			child.layers += 262144

func _on_Area_body_shape_exited(body_id, body, body_shape, area_shape):
	if body_id in echos:
		echos.erase(body_id)
		for child in body.get_children():
			if child is VisualInstance:
				child.layers -= 262144


func _on_Timer_timeout():
	level = 0
	
	for key in echos:
		value = echos[key]
		pos = value['body'].global_transform.origin
		level += max((pos - value['old_body_position']).length()*10.0,10)/(max((pos-global_transform.origin).length()/10.0,1.0))
		value['old_body_position'] = pos
	
	$Cockpit/Viewports/SonarPassif/TextureRect._on_data(level)



func _on_Area2_body_shape_entered(body_id, body, body_shape, area_shape):
	if body_id in echos:
		value = echos[body_id]
		pos = value['body'].global_transform.origin
		var body_speed = pos - value['old_body_position']
		
		var sub_speed = player_direction*current_speed
		
		
	pass

func _on_Speed_controller_reverse_changed():
	direction_changed = true
