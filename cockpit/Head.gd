extends RigidBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var STEER_FORCE_LR = 1.5
export var STEER_FORCE_UD = 0.8

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	rotate_x(-rotation.x)
	rotate_y(-rotation.y)
	rotate_z(-rotation.z)