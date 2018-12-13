extends RigidBody

export var TURN_SPEED = 7
export var LOW_THRUST = 50
export var MED_THRUST = 100
export var FULL_THRUST = 150
export var STEER_FORCE_LR = 1.5
export var STEER_FORCE_UD = 0.8

const MAX_VEL = 22 * 22 # en m/s

var thrust = Vector3()
var linvel = 0

var impulse_left = false
var impulse_right = false
var impulse_up = false
var impulse_down = false

func _ready():
	pass

func get_input():
	if Input.is_action_just_pressed("FullStop"):
		thrust = Vector3()
		print("FullStop")
	if Input.is_action_just_pressed("LowSpeed"):
		thrust = Vector3(0,0,LOW_THRUST)
		print("LowSpeed")
	if Input.is_action_just_pressed("MediumSpeed"):
		thrust = Vector3(0,0,MED_THRUST)
		print("MediumSpeed")
	if Input.is_action_just_pressed("FullSpeed"):
		thrust = Vector3(0,0,FULL_THRUST)
		print("FullSpeed")
		
	if Input.is_action_pressed("move_left"):
		impulse_left = true
	if Input.is_action_just_released("move_left"):
		impulse_left = false
		
	if Input.is_action_pressed("move_right"):
		impulse_right = true
	if Input.is_action_just_released("move_right"):
		impulse_right = false
	
	if Input.is_action_pressed("move_forward"):
		impulse_up = true
	if Input.is_action_just_released("move_forward"):
		impulse_up = false
	
	if Input.is_action_pressed("move_backward"):
		impulse_down = true
	if Input.is_action_just_released("move_backward"):
		impulse_down = false

func _process(delta):
	get_input()
	if (Engine.get_frames_drawn() % 60 == 0):
		print("speed : ", sqrt(linvel) * 3.6, " kph", " / fps : ", Performance.get_monitor(Performance.TIME_FPS))


func _integrate_forces(state):
	linvel = state.linear_velocity.length_squared()
	if (linvel <= MAX_VEL):
		var force = self.get_transform().basis.xform(thrust)
		state.add_force(force, Vector3(0,0,0))
	if (impulse_left):
		state.apply_torque_impulse(Vector3(0,STEER_FORCE_LR,0))
	if (impulse_right):
		state.apply_torque_impulse(Vector3(0,-STEER_FORCE_LR,0))
	if (impulse_up):
		state.apply_torque_impulse(Vector3(0,0,-STEER_FORCE_UD))
	if (impulse_down):
		state.apply_torque_impulse(Vector3(0,0,STEER_FORCE_UD))


