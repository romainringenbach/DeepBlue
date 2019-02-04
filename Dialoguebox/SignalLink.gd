extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
signal transmit_messages()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button4_transmit_message():
	emit_signal("transmit_messages")
	
	pass # replace with function body
