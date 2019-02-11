extends AudioStreamPlayer3D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var activationSound
# Called when the node enters the scene tree for the first time.
func _ready():
	activationSound =  $"."
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_left_click():
	activationSound.play(0.0)
	pass # Replace with function body.

