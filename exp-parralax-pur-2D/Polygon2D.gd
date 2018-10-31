extends Polygon2D

signal position_changed(velocity)
# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const MOVE_SPEED = 150

func _ready():
	pass
	
func _process(delta):
	
	var velocity = Vector2(0,0)
	
	if Input.is_action_pressed("ui_left") :
		velocity.x = velocity.x - MOVE_SPEED
	if Input.is_action_pressed("ui_right") :
		velocity.x = velocity.x + MOVE_SPEED
	if Input.is_action_pressed("ui_up") : 
		velocity.y = velocity.y - MOVE_SPEED
	if Input.is_action_pressed("ui_down"):
		velocity.y = velocity.y + MOVE_SPEED

	emit_signal("position_changed",velocity);
