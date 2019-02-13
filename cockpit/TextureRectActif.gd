extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var updating = false
var top
var bottom

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if updating == true:
		top = get_parent().get_parent().get_node("TopView").get_texture()
		bottom = get_parent().get_parent().get_node("BottomView").get_texture()
		material.set_shader_param("top",top)
		material.set_shader_param("bottom",bottom)

func update():
	updating = !updating
	material.set_shader_param("updating",updating)