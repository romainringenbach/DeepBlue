extends Spatial

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var game_scene = preload("res://Scenes/Terrain/Terrain.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuSound.play_audio()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button2_left_click():
	pass # Replace with function body.


func _on_Button1_left_click():
	$MenuSound.stop_audio()
	get_tree().change_scene_to(game_scene)


func _on_Button3_button_blinking_terminated():
	print("test")
	get_tree().quit()
