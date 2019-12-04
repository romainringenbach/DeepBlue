extends Control

var game_scene = preload("res://Scenes/Terrain/Terrain.tscn")


func _ready():
	$MenuSound.play_audio()

func _on_NewGameBtn_button_down():
	$MenuSound.stop_audio()
	get_tree().change_scene_to(game_scene)
