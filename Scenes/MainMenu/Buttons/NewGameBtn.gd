extends Button

var game_scene = preload("res://Scenes/Terrain/Terrain.tscn")

func _pressed():
	MenuSound.stop_audio()
	get_tree().change_scene_to(game_scene)
