extends TextureRect

export (Texture) var useless
export (ImageTexture) var data
var slide = 0

signal alarm()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var img = useless.get_data()
	img.lock()
	for i in range(1000):
		
		img.set_pixel(i,0,Color(0,0,0,1))
		
	img.unlock()
	data.create_from_image(img)

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass



func _on_data(level):
	
	var img = data.get_data()
	if img != null:
		img.lock()
		img.set_pixel(slide,0,Color(float(level)/1000.0,0,0,1))
		img.unlock()
		if level > 500 :
			emit_signal('alarm')
		data.create_from_image(img)
		slide += 1
		if slide == 1000:
			slide = 0
		material.set_shader_param('slide',slide)
		material.set_shader_param('data',data)