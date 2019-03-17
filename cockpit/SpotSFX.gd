extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


export (bool) var particule_emitting = true
export (Color) var light_color = Color(1,1,1,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Particles.emitting = particule_emitting
	$SpotLight.light_color = light_color

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


