extends Control

var main_title_scene = preload("res://Scenes/MainMenu/MainMenu.tscn")

func _ready():
	pass

func _input(event):
	if event.is_action_released("pause"):
		toggle_game_pause()

func _on_BackBtn_pressed():
	toggle_game_pause()

func toggle_game_pause() -> void:
	var pause_state = not get_tree().paused
	get_tree().paused = pause_state
	self.visible = pause_state

func _on_QuitBtn_pressed():
	toggle_game_pause()
	get_tree().change_scene_to(main_title_scene)
