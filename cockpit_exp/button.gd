extends StaticBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal left_click()

export (Color) var light_color

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	if $"Scene Root/Lamp1".light_color == null and light_color != null:
		$"Scene Root/Lamp1".light_color = light_color

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func set_color(color):
	$"Scene Root/Lamp1".light_color = color

func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			emit_signal("left_click")
