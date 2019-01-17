extends RigidBody

const MASS = 100


const rotation_acc = 1
const max_rotation_velocity = 20

const max_speed_acceleration = 2 #in fact : -1 to 1
const speed_loss = 0.5
const max_speed_velocity = 20

var speed_acceleration = 0.0

var rotate_left = false
var rotate_right = false
var left = false
var right = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	rotate_left = Input.is_action_pressed("ui_rotate_left")
	rotate_right = Input.is_action_pressed("ui_rotate_right")


func _integrate_forces ( state ):

	if rotate_left and state.angular_velocity[1] < max_rotation_velocity:
		state.angular_velocity += Vector3(0,rotation_acc*state.step,0)
	elif rotate_right and state.angular_velocity[1] > -max_rotation_velocity:
		state.angular_velocity += Vector3(0,-rotation_acc*state.step,0)
	else:
		if state.angular_velocity[1] > 0.0:
			state.angular_velocity += Vector3(0,-rotation_acc*state.step,0)
			
		elif state.angular_velocity[1] < 0.0:
			state.angular_velocity += Vector3(0,rotation_acc*state.step,0)
	
	var a = state.get_transform().basis
	
	var dir = state.transform.basis.x.normalized() * state.transform.basis.z.normalized()
	
	if speed_acceleration != 0.0:
		if state.linear_velocity.length() > -max_speed_velocity and state.linear_velocity.length() < max_speed_velocity:
			state.linear_velocity += dir*speed_acceleration * state.step
	else:
		if state.linear_velocity.length() > 0.0:
			state.linear_velocity += dir*-speed_loss * state.step
			if 	state.linear_velocity.length() < 0.0:
				state.linear_velocity = dir*0.0
		elif state.linear_velocity.length() < 0.0:
			state.linear_velocity += dir*speed_loss * state.step
			if 	state.linear_velocity.length() > 0.0:
				state.linear_velocity = dir*0.0
		
func _on_speed_value_changed(value):
	speed_acceleration = max_speed_acceleration*value/100.0-1.0


func _on_mass_value_changed(value):
	mass = MASS*value/100.0
