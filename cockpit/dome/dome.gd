extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var cracking = false
var distance = 0

var distance1 = 100
var distance2 = 200
var distance3 = 1024

var max_distance = 0.0

var audioStream
func _ready():
	# Called wh"AudioStreamPlayer3D"en the node is added to the scene for the first time.
	# Initialization here
	# $CrackPass/TextureRect.material.set_shader_param('previous',$CrackPass.get_texture())
	audioStream = $"CrackAudio"
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass
	
func crack():
	cracking = true
	audioStream.play(2.0)
	if max_distance == 0.0:
		max_distance = distance1
	elif max_distance == distance1:
		max_distance = distance2
	elif max_distance == distance2:
		max_distance = distance3

func _on_Timer_timeout():
	
	if cracking == true:
		distance += 1
		$Sphere.material_override.next_pass.set_shader_param('distance_i',distance)
	if distance >= max_distance:
		cracking = false
		audioStream.stop()
		