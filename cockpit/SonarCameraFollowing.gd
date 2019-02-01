extends InterpolatedCamera

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var _y = get_parent().get_parent().get_node("Viewport3/InterpolatedCamera2").global_transform.basis.get_euler().y
	var __y = global_transform.basis.get_euler().y
	
	var ry= _y-__y 
	
	if (ry > 0.2 or ry < -0.2):
	
		rotate_y(ry)