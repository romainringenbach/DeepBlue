extends InterpolatedCamera

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var ori_rot
var tra

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	ori_rot = global_transform.basis.get_euler()
	tra = translation

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	global_transform.origin = get_node(target).global_transform.origin + tra
	global_transform.basis = get_node(target).global_transform.basis
	
	var rot = global_transform.basis.get_euler()
	
	global_rotate(Vector3(1,0,0),ori_rot.x - rot.x)
	global_rotate(Vector3(0,0,1),ori_rot.z - rot.z)

	
	
	
	