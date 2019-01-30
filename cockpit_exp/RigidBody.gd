extends RigidBody

#export var TURN_SPEED = 7
#export var LOW_THRUST = 50
#export var MED_THRUST = 100
export var FULL_THRUST = 100
export var STEER_FORCE_LR = 1.5
export var STEER_FORCE_UD = 0.8

var speed = 0.0;

var thrust = Vector3()
var linvel = 0

var impulse_left = false
var impulse_right = false
var impulse_up = false
var impulse_down = false

var player_direction = Vector3()

func _ready():
	pass

func get_input():
	
	player_direction = -$Cockpit/Yaw/InterpolatedCamera.get_global_transform().basis.z
	
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
	if (Engine.get_frames_drawn() % 60 == 0):
		print("speed : ", sqrt(linvel) * 3.6, " kph", " / fps : ", Performance.get_monitor(Performance.TIME_FPS))


func _integrate_forces(state):
	linvel = state.linear_velocity.length_squared()
	state.add_force(player_direction*speed, Vector3(0,0,0))
	if (impulse_left):
		state.apply_torque_impulse(Vector3(0,STEER_FORCE_LR,0))
	if (impulse_right):
		state.apply_torque_impulse(Vector3(0,-STEER_FORCE_LR,0))
	if (impulse_up):
		state.apply_torque_impulse(Vector3(0,0,-STEER_FORCE_UD))
	if (impulse_down):
		state.apply_torque_impulse(Vector3(0,0,STEER_FORCE_UD))


func _on_Cockpit_speed_changed(speed_percent):
	
	speed = FULL_THRUST*speed_percent
	
	#thrust = Vector3(0,0,FULL_THRUST*speed)
