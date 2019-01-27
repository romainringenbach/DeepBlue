extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var up = false
var down = false
var left = false
var right = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	
	if Input.is_action_pressed("ui_up") and up == false:
		$AnimationPlayer.play("up")
		up = true
	
	if not Input.is_action_pressed("ui_up") and up == true:
		$AnimationPlayer.play("r_up")
		up = false
	
	if Input.is_action_pressed("ui_down") and down == false:
		$AnimationPlayer.play("down")
		down = true
		
	if not Input.is_action_pressed("ui_down") and down == true:
		$AnimationPlayer.play("r_down")
		down = false
		
	if Input.is_action_pressed("ui_left") and left == false:
		$AnimationPlayer.play("left")
		left = true
	
	if not Input.is_action_pressed("ui_left") and left == true:
		$AnimationPlayer.play("r_left")
		left = false
		
	if Input.is_action_pressed("ui_right") and right == false:
		$AnimationPlayer.play("right")
		right = true
	
	if not Input.is_action_pressed("ui_right") and right == true:
		$AnimationPlayer.play("r_right")
		right = false

