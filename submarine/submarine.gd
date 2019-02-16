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

var player_direction = Vector3()

var echos = {}
var pos
var level
var value

var direction_changed = false

var collision = false
var shake = false

var lateral_mode = false

onready var dialogs_mgr = get_node("Cockpit/PilotHead/Head/Yaw/InterpolatedCamera/Dialogs/DialogueUI")

signal collision_impact()
signal near_body()

func _ready():
	player_direction = $Cockpit.get_global_transform().basis.z
	$Cockpit/Viewports/TopView/Yaw.target = get_path()
	$Cockpit/Viewports/BottomView/Yaw.target = get_path()
	
	dialogs_mgr.LoadFile("tuto1.json")
	dialogs_mgr.StartDialogue()

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

	if lateral_mode == false:

		state.add_force(player_direction*current_speed, Vector3())
		if (impulse_left == true):
			state.apply_torque_impulse(Vector3(0,STEER_FORCE_LR,0))
		if (impulse_right == true):
			state.apply_torque_impulse(Vector3(0,-STEER_FORCE_LR,0))
		if (impulse_up == true):
			state.apply_torque_impulse(Vector3(-STEER_FORCE_UD,0,0))
		if (impulse_down == true):
			state.apply_torque_impulse(Vector3(STEER_FORCE_UD,0,0))

	else:

		if (impulse_left == true):
			state.add_force($Cockpit/T.get_global_transform().basis.z*current_speed*.5, Vector3())
		if (impulse_right == true):
			state.add_force(-$Cockpit/T.get_global_transform().basis.z*current_speed*.5, Vector3())
		if (impulse_up == true):
			state.add_force(-$Cockpit/B.get_global_transform().basis.z*current_speed*.5, Vector3())
		if (impulse_down == true):
			state.add_force($Cockpit/B.get_global_transform().basis.z*current_speed*.5, Vector3())

	# correct submarine orientation

	state.add_force(-state.total_gravity*(mass+get_parent().get_node('Float').mass), Vector3())


func _on_Cockpit_speed_changed(speed_percent):

	current_speed = FULL_THRUST*speed_percent


func _on_Area_body_entered(body):
	for child in body.get_children():
		if child is VisualInstance:
			child.layers += 262144
	if body.get_parent() is VisualInstance:
		body.get_parent().layers += 262144


func _on_Area_body_exited(body):
	for child in body.get_children():
		if child is VisualInstance:
			child.layers -= 262144
	if body.get_parent() is VisualInstance:
		body.get_parent().layers -= 262144

func _on_Timer_timeout():
	level = 0

	for key in echos:
		value = echos[key]
		pos = value['body'].global_transform.origin
		level += max((pos - value['old_body_position']).length()*10.0,10)/(max((pos-global_transform.origin).length()/10.0,1.0))
		value['old_body_position'] = pos

	$Cockpit/Viewports/SonarPassif/ColorRect._on_data(level)



func _on_Area2_body_shape_entered(body_id, body, body_shape, area_shape):
	var body_velocity = Vector3(0,0,0)
	if body is KinematicBody:
		body_velocity = body.linear_velocity

	if ((linear_velocity-body_velocity).length()) > 1.3:
		emit_signal("collision_impact")

	if body.get_collision_layer_bit(7): # Loot taken
		dialogs_mgr.EndDialogue()
		dialogs_mgr.LoadFile("loot_taken.json")
		dialogs_mgr.StartDialogue()

func _on_Speed_controller_reverse_changed():
	direction_changed = true


func _on_Speed_controller_mode_changed(mode):
	lateral_mode = mode


func _on_Area3_body_entered(body):
	emit_signal("near_body")
	if body.get_collision_layer_bit(7): # Loot near
		dialogs_mgr.EndDialogue()
		dialogs_mgr.LoadFile("loot_near.json")
		dialogs_mgr.StartDialogue()


func _on_Area4_body_shape_entered(body_id, body, body_shape, area_shape):
	echos[body_id] = {'body':body,'body_shape':body_shape,'area_shape':area_shape,'old_body_position':body.global_transform.origin}


func _on_Area4_body_shape_exited(body_id, body, body_shape, area_shape):
	if body_id in echos:
		echos.erase(body_id)
