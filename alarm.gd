extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var playing = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func play():
	if playing != true:
		$AnimationPlayer.queue('alarm')
		playing = true
		$AudioStreamPlayer3D.playing = true
		$Sphere/SpotLight.show()
	
func stop():
	playing = false
	$AudioStreamPlayer3D.playing = false
	$Sphere/SpotLight.hide()

func _on_AnimationPlayer_animation_finished(anim_name):
	if playing == true:
		$AnimationPlayer.queue('alarm')
