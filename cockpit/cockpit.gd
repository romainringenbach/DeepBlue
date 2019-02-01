extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal speed_changed(speed)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	$SonarActif/TextureRect.material.set_shader_param("top",$TopView.get_texture())
	$SonarActif/TextureRect.material.set_shader_param("bottom",$BottomView.get_texture())


func _on_Speed_controller_speed_changed(speed):
	emit_signal("speed_changed",speed)
