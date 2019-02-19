extends MultiMeshInstance

export (int) var fish_number = 30
export (float) var diameter = 10.0

func _ready():
	self.multimesh.instance_count = fish_number
	var radius : float = diameter / 2.0
	for i in range(self.multimesh.instance_count):
		var rand_pos = Vector3(randf() * diameter - radius, randf() * diameter - radius, randf() * diameter - radius)
		
		while(rand_pos.length() == 0.0 || rand_pos.length() > radius):
			rand_pos = Vector3(randf() * diameter - radius, randf() * diameter - radius, randf() * diameter - radius)
		
		var position = Transform()
		position = position.translated(rand_pos)
		self.multimesh.set_instance_transform(i, position)
		self.multimesh.set_instance_custom_data(i, Color(randf(), randf(), randf(), randf()))
	
