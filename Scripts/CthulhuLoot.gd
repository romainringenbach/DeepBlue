extends Spatial

onready var area = get_node("Object_5/Area")
var mat : ShaderMaterial = null
var anim : AnimationPlayer = null

var disappearing : bool = false
var timer : float = 0.0

func _ready():
	area.connect("body_entered", self, "_on_body_entered")
	#area.connect("body_exited", self, "_on_body_exited")
	mat = get_node("Object_5").get_surface_material(0)
	anim = get_node("Anim")
	
func _on_body_entered(body):
	# On layer "Submarine"
	if body.get_collision_layer() == area.get_collision_mask():
		print("Looted!")
		disappearing = true
		anim.stop()
	
func _process(delta):
	if disappearing:
		timer += delta
		mat.set_shader_param("noise_threshold", 1.0 - timer)
		if timer >= 1.0:
			disappearing = false
			remove_loot()
			
func remove_loot() -> void:
	print("Die!")
	queue_free()