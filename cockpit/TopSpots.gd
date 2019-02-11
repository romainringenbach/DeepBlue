extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var spotLight

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	spotLight = $"./SpotLight"
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_Button1_left_click():
	if visible == true:
		hide()
	else:
		spotLight.play(0.0)
		show()
