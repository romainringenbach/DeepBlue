extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Spatial_near_active_sonar():
	$Screen_1.alarm()


func _on_Button2_left_click():
	if $Screen_1/Button2.toggle == true:
		$SonarSound.play()
		print("play")
	else:
		$SonarSound.stop()
		print("stop")
