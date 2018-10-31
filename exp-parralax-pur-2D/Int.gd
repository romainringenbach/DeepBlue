extends Polygon2D

var _velocity = Vector2(0,0)

func _ready():
    pass

func _process(delta):

	position = position + _velocity*delta

func _on_Polygon2D_position_changed(velocity):
	_velocity = velocity
	print(_velocity,"\n")
