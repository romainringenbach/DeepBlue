extends Path

onready var path = get_node("PathFollow")
var tween

func _ready():
	tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(path, "unit_offset", 0, 1, 10, tween.TRANS_LINEAR, tween.EASE_IN_OUT)
	tween.set_repeat(true)
	tween.start()

func _process(delta):
	#path.set_offset(path.get_offset() + 1 * delta)
	pass
