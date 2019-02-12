extends AudioStreamPlayer3D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var audioStream
var on = false
# Called when the node enters the scene tree for the first time.
func _ready():
	audioStream = $"."
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button1_left_click():
	on = !on
	if(on):
		audioStream.play(0.0)
	pass # Replace with function body.
