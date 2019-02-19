extends Spatial

export (bool) var sfx_particle = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$SFX_dust/Spatial/Particles.emitting = sfx_particle
	$SFX_dust/Spatial/Particles2.emitting = sfx_particle

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
