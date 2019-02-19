extends Control

var main_title_scene = preload("res://Scenes/MainMenu/MainMenu.tscn")

var game_levels = ["Level1"]

func _ready():
	pass

func _input(event):
	if event.is_action_released("pause"):
		var current_scene : String = get_tree().get_current_scene().name
		if current_scene in game_levels:
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
