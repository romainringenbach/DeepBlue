extends Spatial

var state = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func down():
	if (state != 3):
		state +=1
		if (state == 0):
			$AnimationPlayer.play("down_100-50")
		elif (state == 1):
			$AnimationPlayer.play("down_50_20")
		else:
			$AnimationPlayer.play("down_20_0")
		

func up():
	if (state != 0):
		state -=1
		if (state == 2):
			$AnimationPlayer.play("up_0_20")
		elif (state == 1):
			$AnimationPlayer.play("up_20_50")
		else:
			$AnimationPlayer.play("up_50_100")
	
func down_full():
	if (state == 0):
		state = 3
		$AnimationPlayer.play("down_full")
	else:
		while (state != 3):
			down()
	
func up_full():
	if (state == 3):
		state = 0
		$AnimationPlayer.play("up_full")
	else:
		while(state != 0):
			up()
	