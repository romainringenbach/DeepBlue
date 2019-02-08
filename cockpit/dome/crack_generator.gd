extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var playing = true
var extends_craking = false
var distance = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	# $CrackPass/TextureRect.material.set_shader_param('previous',$CrackPass.get_texture())
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	$Sprite3D.texture = $CrackPass.get_texture()
	
	
func play():
	pass
	
func reset():
	pass

func _on_Timer_timeout():
	
	distance += 1
	$CrackPass/TextureRect.material.set_shader_param('distance_i',distance)