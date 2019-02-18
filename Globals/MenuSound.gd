extends AudioStreamPlayer

var menu_sound = preload("res://PisteAudio/SFX/ambientSound.ogg")

func _ready():
	self.set_stream(menu_sound)
	self.play(0.0)
	
func stop_audio():
	self.stop()
