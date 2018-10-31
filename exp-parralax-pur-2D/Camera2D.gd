extends Camera2D

signal zoomed(camera_center)

const MOVE_SPEED = 150

const MAX_ZOOM_LEVEL = 0.5
const MIN_ZOOM_LEVEL = 4.0
const ZOOM_INCREMENT = 0.05



var _current_zoom_level = 1
var _time = 0
var _delta = 0
var _position = Vector2(0,0)

func _update_zoom(incr, zoom_anchor):
    var old_zoom = _current_zoom_level
    _current_zoom_level += incr
    if _current_zoom_level < MAX_ZOOM_LEVEL:
        _current_zoom_level = MAX_ZOOM_LEVEL
    elif _current_zoom_level > MIN_ZOOM_LEVEL:
        _current_zoom_level = MIN_ZOOM_LEVEL
    if old_zoom == _current_zoom_level:
        return
    
    var zoom_center = zoom_anchor - get_offset()
    var ratio = 1-_current_zoom_level/old_zoom
    #set_offset(get_offset() + zoom_center*ratio)
    
    set_zoom(Vector2(_current_zoom_level, _current_zoom_level))
    position = _position
    emit_signal("zoomed",get_camera_screen_center ( ))



func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here.
	make_current()
	
func _process(delta):
	_delta = delta
	
	var velocity = Vector2(0,0)
	
	if Input.is_action_pressed("ui_left") :
		velocity.x = velocity.x - MOVE_SPEED
	if Input.is_action_pressed("ui_right") :
		velocity.x = velocity.x + MOVE_SPEED
	if Input.is_action_pressed("ui_up") : 
		velocity.y = velocity.y - MOVE_SPEED
	if Input.is_action_pressed("ui_down"):
		velocity.y = velocity.y + MOVE_SPEED

	position = position + velocity*_delta
	_position = position

func _input(event):
	
	if event.is_action("ui_zoom_in") : 
		_update_zoom(-ZOOM_INCREMENT, get_camera_screen_center ( ))
	if event.is_action("ui_zoom_out"):
		_update_zoom(ZOOM_INCREMENT, get_camera_screen_center ( ))