extends MeshInstance

export (String) var label1
export (Color) var color1

export (String) var label2
export (Color) var color2

export (String) var label3
export (Color) var color3

export (String) var label4
export (Color) var color4

export (String) var label5
export (Color) var color5

export (String) var label6
export (Color) var color6

export (String) var label7
export (Color) var color7

export (String) var label8
export (Color) var color8

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
