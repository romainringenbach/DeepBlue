extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var b = randi()%19+1
	var name = "Highrise_"+str(b)
	var node = get_node(name)
	if node == null:
		name = "highrise_"+str(b)
		node = get_node(name)
	
	
	node.show()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
