extends Button

var main_scene = preload("res://Scenes/MainMenu/MainMenu.tscn")

func _pressed():
	get_tree().change_scene_to(main_scene)