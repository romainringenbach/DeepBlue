extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	$CrackPass/TextureRect.material.set_shader_param('noise',$Noise.get_texture())
	$CrackPass/TextureRect.material.set_shader_param('previous',$CrackPass.get_texture())

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
	#$CrackPass/TextureRect.material.set_shader_param('previous',$CrackPass.get_texture())
	
func play():
	pass
	
func reset():
	pass