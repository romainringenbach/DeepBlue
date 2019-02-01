extends Node

var mine = preload("res://mine_field/Mine.tscn")
const poissonDisc = preload("res://mine_field/PoissonDiscSampling.gd")

export (float) var radius = 10
export (Vector2) var region_size = Vector2(100, 100)
export (int) var rejection_sample = 30

func _ready():	
	place_mines()
	
func place_mines():
	var points = poissonDisc.generate_points(radius, region_size, rejection_sample)
	for point in points:
		var mineNode = mine.instance()
		mineNode.translate(Vector3(point.x, 0, point.y))
		self.add_child(mineNode)