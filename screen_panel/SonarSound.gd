extends AudioStreamPlayer3D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var on = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button2_left_click():
	on = !on
	if(on):
		play(0.0)
