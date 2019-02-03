extends AnimationPlayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal finish_queue()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_AnimationPlayer2_animation_finished(anim_name):
	if animation_get_next(anim_name) == '':
		emit_signal("finish_queue")
