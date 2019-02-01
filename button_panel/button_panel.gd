extends MeshInstance

export (String) var label1 = "nothing"
export (Color) var color1 = Color(1,1,1,1)

export (String) var label2 = "nothing"
export (Color) var color2 = Color(1,1,1,1)

export (String) var label3 = "nothing"
export (Color) var color3 = Color(1,1,1,1)

export (String) var label4 = "nothing"
export (Color) var color4 = Color(1,1,1,1)

export (String) var label5 = "nothing"
export (Color) var color5 = Color(1,1,1,1)

export (String) var label6 = "nothing"
export (Color) var color6 = Color(1,1,1,1)

export (String) var label7 = "nothing"
export (Color) var color7 = Color(1,1,1,1)

export (String) var label8 = "nothing"
export (Color) var color8 = Color(1,1,1,1)

signal on_button_1()
signal on_button_2()
signal on_button_3()
signal on_button_4()
signal on_button_5()
signal on_button_6()
signal on_button_7()
signal on_button_8()

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$Label1.set_label(label1)
	$Button1.set_color(color1)
	
	$Label2.set_label(label2)
	$Button2.set_color(color2)
	
	$Label3.set_label(label3)
	$Button3.set_color(color3)
	
	$Label4.set_label(label4)
	$Button4.set_color(color4)
	
	$Label5.set_label(label5)
	$Button5.set_color(color5)
	
	$Label6.set_label(label6)
	$Button6.set_color(color6)
	
	$Label7.set_label(label7)
	$Button7.set_color(color7)
	
	$Label8.set_label(label8)
	$Button8.set_color(color8)

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


func _on_Button4_left_click():
	emit_signal("on_button_4")


func _on_Button5_left_click():
	emit_signal("on_button_5")


func _on_Button6_left_click():
	emit_signal("on_button_6")


func _on_Button7_left_click():
	emit_signal("on_button_7")


func _on_Button8_left_click():
	emit_signal("on_button_8")
