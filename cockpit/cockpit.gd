extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var echos = {}
var pos
var level
var value

signal speed_changed(speed)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	$Viewports/SonarActif/TextureRect.material.set_shader_param("top",$Viewports/TopView.get_texture())
	$Viewports/SonarActif/TextureRect.material.set_shader_param("bottom",$Viewports/BottomView.get_texture())
	



func _on_Speed_controller_speed_changed(speed):
	emit_signal("speed_changed",speed)


func _on_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	echos[body_id] = {'body':body,'body_shape':body_shape,'area_shape':area_shape,'old_body_position':body.global_transform.origin}
	for child in body.get_children():
		if child is VisualInstance:
			child.layers += 262144

func _on_Area_body_shape_exited(body_id, body, body_shape, area_shape):
	if body_id in echos:
		echos.erase(body_id)
		for child in body.get_children():
			if child is VisualInstance:
				child.layers -= 262144


func _on_Timer_timeout():
	level = 0
	
	for key in echos:
		value = echos[key]
		pos = value['body'].global_transform.origin
		level += max((pos - value['old_body_position']).length()*10,10)/((pos-global_transform.origin).length()/10)
		value['old_body_position'] = pos
		
	$Viewports/SonarPassif/TextureRect._on_data(level)
