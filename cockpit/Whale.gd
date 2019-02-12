extends AudioStreamPlayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var audioStream
# Called when the node enters the scene tree for the first time.
func _ready():
	audioStream = $"."
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var proba = randf()
	if (proba<0.0005):
		audioStream.play(0.0)
	pass
