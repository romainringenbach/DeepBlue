extends ViewportContainer

signal position_changed(new_position)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass



func _on_Polygon2D_position_changed(new_position):
	emit_signal("position_changed",new_position);