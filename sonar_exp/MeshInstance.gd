tool
extends MeshInstance
func _ready():
	var t = $"Viewport".get_texture()
	get_surface_material(0).albedo_texture = t
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
