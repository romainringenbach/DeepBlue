extends HSlider

func _ready():
	self.set_value(Options.slider_value)

func _on_HSlider_value_changed(value):
	Options.set_master_volume(value)
