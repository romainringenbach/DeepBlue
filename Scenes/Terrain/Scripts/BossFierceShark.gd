extends Spatial

onready var path = get_parent().get_parent()
onready var area = get_parent()
var tween : Tween = null
export (float) var loop_duration = 10.0
const FSM = preload("res://Scripts/FSM.gd")
var fsm = null

func _ready():
	
	area.connect("body_entered", self, "_on_body_entered")
	area.connect("body_exited", self, "_on_body_exited")
	
	tween = Tween.new()
	add_child(tween)
	tween.interpolate_property(path, "unit_offset", 0, 1, loop_duration, tween.TRANS_LINEAR, tween.EASE_IN_OUT)
	tween.set_repeat(true)
	tween.start()

func _process(delta):
	#path.set_offset(path.get_offset() + 1 * delta)
	pass
	
func _on_body_entered(body):
	print("Body Entered")
	tween.stop(path, "unit_offset")
	pass
	
func _on_body_exited(body):
	print("Body Exited")
	tween.resume(path, "unit_offset")
	pass