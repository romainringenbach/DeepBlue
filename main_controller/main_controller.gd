extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var animation_done_status = {
	"up" : false,
	"r_up" : true,
	"down" : false,
	"r_down" : true,
	"left" : false,
	"r_left" : true,
	"right" : false,
	"r_right" : true
}


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	
	_anim(Input.is_action_pressed("ui_up"),"up","down",$AnimationPlayer)
	_anim(Input.is_action_pressed("ui_down"),"down","up",$AnimationPlayer)
	_anim(Input.is_action_pressed("ui_left"),"left","right",$AnimationPlayer2)
	_anim(Input.is_action_pressed("ui_right"),"right","left",$AnimationPlayer2)
	

func _anim(direction, direction_name, opposite_direction_name,player):
	var animation_name = direction_name 
	var r_animation_name = "r_"+direction_name
	var opposite_animation_name = opposite_direction_name 
	var r_opposite_animation_name = "r_"+opposite_direction_name
	
	if direction == true and animation_done_status[animation_name] == false and animation_done_status[r_opposite_animation_name] == true:
		if player.current_animation == "":
			player.play(animation_name)
			animation_done_status[r_opposite_animation_name] = false
			animation_done_status[r_animation_name] = false
			animation_done_status[opposite_animation_name] = false
		
	if direction == false and animation_done_status[animation_name] == true:
		player.play(r_animation_name)
		animation_done_status[animation_name] = false
		animation_done_status[r_opposite_animation_name] = false
		animation_done_status[opposite_animation_name] = false

func _on_AnimationPlayer_animation_finished(animation_name):
	animation_done_status[animation_name] = true


func _on_AnimationPlayer2_animation_finished(animation_name):
	animation_done_status[animation_name] = true
