extends RichTextLabel

var delta_time = 0
export var speed = 0.1
export(String, MULTILINE) var dialogue_text = ""
export var confirm_action = "ui_accept"
var current_page = 0
var pages = []

export(bool) var read = false
export(bool) var fromFile = false

export(String, FILE) var f setget file_set, file_get

var reading = true
var sprite

func _ready():
	sprite = get_node("../DialogBox")
	sprite.hide()
	visible_characters = 0
	parse_dialogue_text()
	text = pages[current_page]
	set_process_input(true)
	set_process(true)

func parse_dialogue_text():
	pages = dialogue_text.split(";")
	for i in range(pages.size()):
		pages[i] = pages[i].replace("\n","")

func text_advance():
	if(text.length() == visible_characters):
		current_page = current_page + 1
		visible_characters = 0
		delta_time = 0
		if(pages.size() - 1 >= current_page):
			text = pages[current_page]
		else:
			get_parent().queue_free()

func text_update():
	if(text.length() > visible_characters):
		visible_characters = visible_characters + 1
	else: 
		reading = false

func _input(event):
	if(event.is_action_released(confirm_action)):
		if(visible_characters == text.length()):
			text_advance()
		else:
			visible_characters = text.length()

func _process(delta):
	if reading:
		if(delta_time > speed):
			delta_time = 0
			text_update()
			delta_time = delta_time + delta
	pass

func _display_message():
	if fromFile:
		load_file(f)
	if read :
		reading = true	
	else :
		visible_characters = text.length()

func load_file(filename):
	var fi = File.new()
	print(filename)
	fi.open(filename,fi.READ)
	var index = 0
	while not fi.eof_reached():
		var line = fi.get_line()
		pages[index] = line
		index += 1
	fi.close()


func file_set(new_value):
	f = new_value

func file_get():
	return f # Getter must return a value.



func _on_SimpleDialogueBox_transmit_messages():
	sprite.show()
	_display_message()
	pass # replace with function body
