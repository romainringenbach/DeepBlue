extends Spatial

var lamp
var click_on = false

export (int) var type = 0

signal click()

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	lamp = $Lamp1
	lamp.hide()

func _process(delta):
		# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if click_on:
		
		
		click_on = false


func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			$AnimationPlayer.play("default")
			
			if type == 0:
				if lamp.is_visible_in_tree():
					lamp.hide()
				else:
					lamp.show()
			else:
				$AnimationPlayer2.play("light")
