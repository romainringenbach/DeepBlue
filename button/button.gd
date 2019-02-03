extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

signal left_click()

signal button_blinking_terminated()

export (int) var type = 0
export (Color) var color = Color()
export (int) var blinking_duration = 1
export (bool) var set_up = false

var blink = false
var hold = false
var toggle = false
var waiting_for_queue_end = false
var blink_count = 0

func _set_hold_and_blink():
	if type == 0 or type == 2:
		hold = true
	else:
		hold = false
		
	if type == 1 or type == 2:
		blink = true
	else:
		blink = false
	
func _set_color():
	$"Cube.001".material_override.emission = color

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	if set_up == true:
		if type >= 3 and type < 0:
			print('type out of range, 0,1 or 3 are accepted only')
		else:
			_set_hold_and_blink()
			_set_color()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func set_up_button(ntype,ncolor,nblinking_duration=1):
	if ntype >= 3 and ntype < 0:
		print('type out of range, 0,1 or 3 are accepted only')
	else:
		type = ntype
		color = ncolor
		blinking_duration = nblinking_duration
		set_up = true
		_set_hold_and_blink()
		_set_color()
	pass
	

func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			$AnimationPlayer.play("default")
			if set_up == true:
				if toggle == false:
					toggle = true
					if blink == true:
						for t in range(blinking_duration):
							$AnimationPlayer2.queue('blink')
					if hold == true:
						$AnimationPlayer2.queue('light_on')
					
				else:
					toggle = false
					if hold == true:
						$AnimationPlayer2.queue('light_off')
			emit_signal("left_click")

func blink():
	toggle = true
	$AnimationPlayer2.queue('blink')

func _on_AnimationPlayer2_finish_queue():
	if type == 1:
		toggle = false
		
	if type == 3 and toggle:
		$AnimationPlayer2.queue('blink')
		
	if toggle == false:
		emit_signal("button_blinking_terminated")