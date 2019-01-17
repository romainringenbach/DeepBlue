extends StaticBody

var vp
var mi

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	vp = $Viewport
	mi = $MeshInstance
	
	
	var t = vp.get_texture()
	#mi.get_surface_material(0).albedo_texture = t

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
