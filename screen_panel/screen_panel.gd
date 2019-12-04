extends MeshInstance

export (ViewportTexture) var viewport_texture
export (Texture) var none_texture
export (bool) var already_on

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	if already_on == true:
		$MeshInstance.material_override.set_shader_param("texture_albedo",viewport_texture)
	
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button1_left_click():
	if $Button1.toggle == true:
		$MeshInstance.material_override.set_shader_param("texture_albedo",viewport_texture)
	else:
		$MeshInstance.material_override.set_shader_param("texture_albedo",none_texture)