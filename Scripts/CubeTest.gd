extends Spatial

export (float) var speed = 5.0

func _ready():
	pass

func _process(delta):
	translate(Vector3(-1, 0, 0) * delta * speed)