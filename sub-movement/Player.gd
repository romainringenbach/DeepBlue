extends KinematicBody

var camera_angle = 0
var mouse_sensitivity = 0.2
var camera_change = Vector3()

var velocity = Vector3()
var player_direction = Vector3()

#fly variable
const FLY_SPEED = 20
const FLY_ACC = 2		
var flying = false


#walk and running variable
const WALK_SPEED = 20
const RUN_SPEED = 40
const ACCELERATION = 2
const DECCELERATION = 6

var jumping = 15
var has_contact = false

#gravity
const gravity = 9.8*3
const MAX_SLOPE_ANGLE = 35

const MAX_STAIRS_SLOPE = 20
const STAIR_JUMP_HEIGHT = 6
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#We are moving around a kinematic body wich is a physics body
func _physics_process(delta):
	_aim()
	if flying:
		_fly(delta)
	else:
		_walk(delta)
	

func _input(event):
	if event is InputEventMouseMotion:
		camera_change=event.relative
		
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _fly(delta):
	player_direction = Vector3()
	
	#Basis hold the direction of the object's local axes, so we use it as a reference for rotation
	var camera_direction = $Head/Camera.get_global_transform().basis
	
	#change direction
	if Input.is_action_pressed("move_forward"):
		player_direction -= camera_direction.z
	if Input.is_action_pressed("move_backward"):
		player_direction += camera_direction.z
	if Input.is_action_pressed("move_left"):
		player_direction -= camera_direction.x
	if Input.is_action_pressed("move_right"):
		player_direction += camera_direction.x
		
	#To have the same speed no matter what
	player_direction = player_direction.normalized()
	
	#Target where the player want to move
	var target = player_direction * FLY_SPEED
	
	#linearinterpolate to gradually increase the speed
	#multiply to delta to down the FLY value (has to be a value between 0 and 1)
	velocity = velocity.linear_interpolate(target, FLY_ACC * delta)
	
	#automatic function which detect collision for us
	move_and_slide(velocity)
	
func _walk(delta):
	player_direction = Vector3()
	
	#Basis hold the direction of the object's local axes, so we use it as a reference for rotation
	var camera_direction = $Head/Camera.get_global_transform().basis
	
	#change direction
	if Input.is_action_pressed("move_forward"):
		player_direction -= camera_direction.z
	if Input.is_action_pressed("move_backward"):
		player_direction += camera_direction.z
	if Input.is_action_pressed("move_left"):
		player_direction -= camera_direction.x
	if Input.is_action_pressed("move_right"):
		player_direction += camera_direction.x
	
	player_direction.y = 0
	#To have the same speed no matter what
	player_direction = player_direction.normalized()
	
	if is_on_floor():
		has_contact = true
		var n = $Tall.get_collision_normal()
		var slope_angle = rad2deg(acos(n.dot(Vector3(0,1,0))))
		if slope_angle > MAX_SLOPE_ANGLE:
			velocity.y -= gravity*delta
	else:
		if !$Tall.is_colliding():
			has_contact = false
		velocity.y -= gravity*delta
		
	if (has_contact and !is_on_floor()):
		move_and_collide(Vector3(0,-1,0))
	
	if (player_direction.length()>0 and $Stairs.is_colliding()):
		var stair_normal = $Stairs.get_collision_normal()
		var stairs_angle = rad2deg(acos(stair_normal.dot(Vector3(0,1,0))))
		if stairs_angle < MAX_STAIRS_SLOPE:
			velocity.y = STAIR_JUMP_HEIGHT
			has_contact = false
	
	var temp_velocity = velocity
	temp_velocity.y = 0
	
	var speed
	if Input.is_action_pressed("move_sprint"):
		speed = RUN_SPEED
	else:
		speed = WALK_SPEED
		
	#Target where the player want to move
	var target = player_direction * speed
	
	var acceleration
	#if the same direction, dot positive else negative
	if player_direction.dot(temp_velocity) > 0:
		acceleration = ACCELERATION
	else:
		acceleration = DECCELERATION
	
	#linearinterpolate to gradually increase the speed
	#multiply to delta to down the FLY value (has to be a value between 0 and 1)
	temp_velocity = temp_velocity.linear_interpolate(target, acceleration * delta)
	
	#compute the velocity only on x and z axis (we nulify the y value where we wants to go)
	velocity.x = temp_velocity.x
	velocity.z = temp_velocity.z
	 
	if has_contact and Input.is_action_just_pressed("jump"):
		velocity.y = jumping
		has_contact = false
	
	#automatic function which detect collision for us
	#However if the user is running on a wall the velocity would be different so we indicate the direction which is up (the normal of the floor)
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	
	$Stairs.translation.x = player_direction.x
	$Stairs.translation.z = player_direction.z
	
		
func _aim():
	if camera_change.length() > 0:
		$Head.rotate_y(deg2rad(-camera_change.x) * mouse_sensitivity)
		var change = -camera_change.y * mouse_sensitivity
		if change + camera_angle < 80 and change + camera_angle >-80:
			$Head/Camera.rotate_x(deg2rad(change))
			camera_angle +=change
		camera_change = Vector3()

func _on_Area_body_entered(body):
	if body.name == "Player":
		flying = true
	pass # replace with function body


func _on_Area_body_exited(body):
	if body.name == "Player":
		flying = false
	pass # replace with function body
