extends OmniLight

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	hide()


func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass


func _on_Scene_Root_click():
	if visible: 
		hide ()
	else:
		show ()
	print("et ton père ?!")
	print (visible)
