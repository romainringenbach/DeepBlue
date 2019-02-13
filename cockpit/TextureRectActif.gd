extends ColorRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var updating = false


export (ImageTexture) var top
export (ImageTexture) var bottom

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if updating == true:
		top.create_from_image(get_parent().get_parent().get_node("TopView").get_texture().get_data())
		bottom.create_from_image(get_parent().get_parent().get_node("BottomView").get_texture().get_data())
		material.set_shader_param("top",top)
		material.set_shader_param("bottom",bottom)

func update():
	updating = !updating
	material.set_shader_param("updating",updating)