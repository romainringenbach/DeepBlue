extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (float) var minimum_impact_force = 5.0

signal speed_changed(speed)
signal gameover()


var life = 3

var max_shaky = 0.3


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass
	
func _on_Speed_controller_speed_changed(speed):
	emit_signal("speed_changed",speed)
		
		


func _on_Submarine_collision_impact():

	$SButton1/Buttons_1/Button3.blink()
	$Alarm.play()
	
	
	if $Cockpit.shield_closed == false :
		$Cockpit/dome.crack()
		$"Measures/Measure 1".down()
		$"Measures/Measure 2".down()
		$"Measures/Measure 3".down()
		$"Measures/Measure 4".down()
		$"Measures/Measure 5".down()
		
		life -= 1
		if life == 0:
			emit_signal('gameover')