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
	var _rot = get_node(target).global_transform.basis.get_euler()
	
	var rot = global_transform.basis.get_euler()
	
	var r = Vector3(ori_rot.x - rot.x,_rot.y-rot.y,ori_rot.z - rot.z)
	
	
	if r.x < -0.01 or r.x > 0.01:
		rotate_x(r.x)
	if r.z < -0.01 or r.z > 0.01:
		rotate_z(r.z)
	if r.y < -0.01 or r.y > 0.01:
		rotate_y(r.y)
	
	
	

	
	
	
	