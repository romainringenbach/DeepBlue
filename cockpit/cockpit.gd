extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (float) var minimum_impact_force = 5.0

signal speed_changed(speed)


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	$Viewports/SonarActif/TextureRect.material.set_shader_param("top",$Viewports/TopView.get_texture())
	$Viewports/SonarActif/TextureRect.material.set_shader_param("bottom",$Viewports/BottomView.get_texture())
	
func _on_Speed_controller_speed_changed(speed):
	emit_signal("speed_changed",speed)
		
		


func _on_Submarine_collision_impact(impact_force):
	print(impact_force)
	if impact_force > 10000:
		$SButton1/Buttons_1/Button3.blink()
		$Alarm.play()
