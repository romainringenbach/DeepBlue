extends HSlider

var master_bus_index : int
var sound_volume_db : float
var slider_value : float = 100.0

func _ready():
	master_bus_index = AudioServer.get_bus_index("Master")
	sound_volume_db = AudioServer.get_bus_volume_db(master_bus_index)
	self.set_value(slider_value)
	
func set_master_volume(value : float):
	slider_value = value
	var normalized_cubed = (value / 100.0) - 1.0
	normalized_cubed *= normalized_cubed * normalized_cubed
	var new_volume_db : float = 45.0 * normalized_cubed
	AudioServer.set_bus_volume_db(master_bus_index, new_volume_db)
	sound_volume_db = new_volume_db


func _on_HSlider_value_changed(value):
	set_master_volume(value)
