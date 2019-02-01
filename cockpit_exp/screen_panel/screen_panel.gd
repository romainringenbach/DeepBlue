extends MeshInstance

signal on_button_1()
signal on_button_2()
signal on_button_3()

export (Color) var color1 = Color(1,1,1,1)
export (Color) var color2 = Color(1,1,1,1)
export (Color) var color3 = Color(1,1,1,1)

export (String) var label1 = "nothing"
export (String) var label2 = "nothing"
export (String) var label3 = "nothing"

export (ViewportTexture) var viewport_texture

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$Label1.set_label(label1)
	$Label2.set_label(label2)
	$Label3.set_label(label3)
	
	$Button1.set_color(color1)
	$Button2.set_color(color2)
	$Button3.set_color(color3)
	
	$Sprite3D.texture = viewport_texture
	
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Button1_left_click():
	emit_signal("on_button_1")


func _on_Button2_left_click():
	emit_signal("on_button_2")


func _on_Button3_left_click():
	emit_signal("on_button_3")
