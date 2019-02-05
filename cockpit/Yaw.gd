extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (float) var max_shaky = 5
export (float) var max_shaky_fov = 5

var force_percent = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	randomize()
	#$InterpolatedCamera.h_offset = rand_range(-max_shaky * force_percent,max_shaky * force_percent)
	#$InterpolatedCamera.v_offset = rand_range(-max_shaky * force_percent,max_shaky * force_percent)
	#$InterpolatedCamera.fov = rand_range(-max_shaky_fov * force_percent + $InterpolatedCamera.nfov,max_shaky_fov * force_percent + $InterpolatedCamera.nfov)