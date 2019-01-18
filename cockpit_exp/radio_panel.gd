extends MeshInstance

signal on_button_1()
signal on_button_2()

export (Color) var color1
export (Color) var color2
export (String) var label1
export (String) var label2

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$Button1.set_color(color1)
	$Button2.set_color(color2)
	$Label1.set_label(label1)
	$Label2.set_label(label2)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button1_left_click():
	emit_signal("on_button_1")


func _on_Button2_left_click():
	emit_signal("on_button_2")
