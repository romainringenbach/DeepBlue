extends Spatial

signal speed_changed(speed)

var current_speed = 0.0
var real_speed = 0.0
const BOOST_SPEED = 1.5

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
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


func _on_Boost_left_click():
	_update_speed()


func _on_Boost_button_blinking_terminated():
	_update_speed()
