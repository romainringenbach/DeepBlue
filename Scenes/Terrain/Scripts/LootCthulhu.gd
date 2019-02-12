extends Spatial

onready var area = get_node("Object_5/Area")

func _ready():
	area.connect("body_entered", self, "_on_body_entered")
	area.connect("body_exited", self, "_on_body_exited")

	
func _on_body_entered(body):
	# On layer "Submarine"
	if body.get_collision_layer() == area.get_collision_mask():
		print("Looted!")
	pass
	
func _on_body_exited(body):
	pass