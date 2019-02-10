extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (Color) var color = Color(1,1,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sphere.material_override.emission = color
	$SpotLight.light_color = color
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
