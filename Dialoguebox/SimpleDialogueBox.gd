extends RichTextLabel

var delta_time : float = 0
export (float) var speed = 0.1
export (String, MULTILINE) var dialogue_text = ""
export var confirm_action : String = "ui_accept"
var current_page : int = 0
var pages = []
export (String, FILE) var f = null

func _ready():
	visible_characters = 0
	if f != null:
		load_file(f)
	else:
		parse_dialogue_text()
	text = pages[current_page]
	set_process_input(true)
	set_process(true)

func parse_dialogue_text() -> void:
	pages = dialogue_text.split(";")
	for i in range(pages.size()):
		pages[i] = pages[i].replace("\n","")

func text_advance() -> void:
	if(text.length() == visible_characters):
		current_page = current_page + 1
		visible_characters = 0
		delta_time = 0
		if(pages.size() - 1 >= current_page):
			text = pages[current_page]
		else:
			get_parent().queue_free()

func text_update() -> void:
	if(text.length() > visible_characters):
		visible_characters = visible_characters + 1

func _input(event):
	if(event.is_action_released(confirm_action)):
		if(visible_characters == text.length()):
			text_advance()
		else:
			visible_characters = text.length()

func _process(delta):
	if(delta_time > speed):
		delta_time = 0
		text_update()
	delta_time = delta_time + delta

func load_file(filename : String) -> void:
	var fi : File = File.new()
#	print(filename)
	var err : int = fi.open(filename,fi.READ)
	if err != OK:
		print("Couldn't read file!")
		get_parent().queue_free()
	while not fi.eof_reached():
		var line : String = fi.get_line()
		line = line.replace("\n", "")
		pages.append(line)
	fi.close()
	
func set_file(filename : String) -> void:
	f = filename