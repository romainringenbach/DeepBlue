extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_transform.origin = get_parent().get_node("MainCore").global_transform.origin
	global_transform.basis.z = get_parent().get_node("MainCore").global_transform.basis.z
