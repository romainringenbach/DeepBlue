extends AudioStreamPlayer3D

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

func alarm():
	if get_parent().get_node('Button3').toggle == false:
		get_parent().get_node('Button3').blink()
		playing = true

func _on_Button3_button_blinking_terminated():
	playing = false
