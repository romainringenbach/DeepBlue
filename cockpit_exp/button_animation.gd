extends Spatial

var lamp

signal click()

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	lamp = $Lamp
	#lamp.hide()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			if lamp.is_visible_in_tree():
				lamp.hide()
				print("lamp hide")
			else:
				lamp.show()
				print("lamp show")
			emit_signal("click")
			print("mother fucker")
