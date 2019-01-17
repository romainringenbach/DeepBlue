extends Spatial

export (String) var text_label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	if ($MeshInstance2/Viewport/Label.text == null and text_label != null):
		$MeshInstance2/Viewport/Label.text = text_label

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func set_label(text):
	$MeshInstance2/Viewport/Label.text = text