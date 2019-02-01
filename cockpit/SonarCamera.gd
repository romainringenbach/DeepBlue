extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


var last_rot_y = 0

var target

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	
	global_transform.origin = get_node(target).global_transform.origin
	var _rot = get_node(target).global_transform.basis.get_euler()
	
	var rot = global_transform.basis.get_euler()
	
	
	var ry = _rot.y-rot.y
	
	if ry < -0.1 or ry > 0.1:
		rotate_y(ry)
	
	
	

	
	
	
	