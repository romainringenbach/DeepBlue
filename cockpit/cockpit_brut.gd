extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var shield_closed = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass



func _on_Buttons_1_on_button_8():
	if $AnimationPlayer.current_animation == "":
		if shield_closed == true:
			$AnimationPlayer.play("open_shield")
		else:
			$AnimationPlayer.play("close_shield")
	elif $AnimationPlayer.current_animation == "open_shield":
		$AnimationPlayer.play("close_shield")
	elif $AnimationPlayer.current_animation == "close_shield":
		$AnimationPlayer.play("open_shield")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "close_shield":
		shield_closed = true
	if anim_name == "open_shield":
		shield_closed = false
