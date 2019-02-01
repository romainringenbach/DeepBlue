extends TextureRect

var current = null
var pre = null

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass

func _on_Timer_timeout():
	
	current = get_parent().get_parent().get_node("SonarActif").get_texture()
	if pre != null:
		material.set_shader_param("current",current)
		material.set_shader_param("previous",pre)
		print("eeee")
	pre = current
