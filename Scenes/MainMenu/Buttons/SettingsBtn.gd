extends Button

export (PackedScene) var scene = null

func _pressed():
	if scene != null:
		get_tree().change_scene_to(scene)
