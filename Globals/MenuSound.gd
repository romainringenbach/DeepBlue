extends AudioStreamPlayer

var menu_sound = preload("res://PisteAudio/SFX/ambientSound.ogg")

func _ready():
	self.set_stream(menu_sound)
	
func stop_audio():
	if self.is_playing():
		self.stop()
	
func play_audio():
	if !self.is_playing():
		self.play(0.0)
