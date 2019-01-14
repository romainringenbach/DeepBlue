extends OmniLight

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var l = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	light_energy = 0.5

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Scene_Root_click():
	if l == true: 
		l = false
		light_energy = 0.0
	else :
		l = true
		light_energy = 0.5
