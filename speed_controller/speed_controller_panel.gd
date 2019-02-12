extends Spatial

signal speed_changed(speed)
signal reverse_changed()

var current_speed = 0.0
var real_speed = 0.0
const BOOST_SPEED = 1.5

const MIN_UNIT_DB = -2
const MAX_UNIT_DB = 5
const DIFFERENCES = MAX_UNIT_DB-MIN_UNIT_DB

export (int) var audioSpeedBoost = 2
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var motorSound
var boostMode = false
var boostOver = false
var prev_speed = real_speed

var pitch_scale
var volume_db
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	motorSound = $"../Cockpit/Motor2"
	volume_db = MIN_UNIT_DB
	motorSound.set_volume_db(volume_db)
	pitch_scale = motorSound.get_pitch_scale()
	pass

func _process(delta):
		
	if boostMode:
		pitch_scale = motorSound.get_pitch_scale() + 0.001*audioSpeedBoost
		motorSound.set_pitch_scale(clamp(pitch_scale,pitch_scale,2.5))
		volume_db = clamp(volume_db+0.01, MIN_UNIT_DB+abs(current_speed)*MAX_UNIT_DB/BOOST_SPEED ,MAX_UNIT_DB)	
	else:
		volume_db = clamp(volume_db - 0.01,MIN_UNIT_DB+abs(current_speed)*DIFFERENCES/BOOST_SPEED, MAX_UNIT_DB) 
		motorSound.set_pitch_scale(clamp(motorSound.get_pitch_scale()-0.001*audioSpeedBoost,1+abs(current_speed)/2,2.5))
	motorSound.set_volume_db(volume_db)

func _update_speed():
	if $Boost.toggle == true:
		current_speed = BOOST_SPEED
		
	else:
		current_speed = real_speed
	if ($Reverse.toggle == true and current_speed > 0) or ($Reverse.toggle == false and current_speed < 0):
		current_speed = -current_speed
		
	
		
	emit_signal("speed_changed",current_speed);
		

func _on_Scene_Root_position_changed(percent):
	real_speed = percent
	_update_speed()


func _on_Reverse_left_click():
	_update_speed()
	emit_signal('reverse_changed')
	


func _on_Boost_left_click():
	boostMode = true
	_update_speed()


func _on_Boost_button_blinking_terminated():
	boostMode = false
	_update_speed()
