#----NOTES:
#--Curent script supports up to 4 possible answers, if you need more make sure to set up the buttons and
#change the number acordingly at the clamp() function
#--Conditionals are not Implemented, if you need conditionals concider the solution found at:
# https://godotengine.org/asset-library/asset/273
#--This is a very simple demo, made for people getting started with json parsing / graph traversing
#--The setup of this graph traversion is perfect for loops and jumping around, but due to the free form
#of the json format and id tracking you could get mixed up quite fast, quite easily, if you need a really
#intricate dialogue mapping it out on papper or drawing software is advised
#--Force and Random are stored as a common typecast int->bool (where 0 == false else true)

#----HOW TO----#
#-- Get a reference of the script in whatever way you prefer
#-- Use LoadFile(string x) and pass it the name of the dialogue file you want loaded (IMPORTANT: path and extension are already set, do not add the .json extension)
#-- Call StartDialogue() whenever you want the dialogue to start
#-- The rest is handled in the script already , and the buttons are updated dynamicly.



extends Panel

#---File---#
var file_name = "tuto1.json" # You could pass a new file here on area body enter or whenever you feel like
var nodes # containes all the nodes of the current dialogue


#----DATA (from file)-----#
var curent_node_id = -1 # handles the current node we are traversing Note: -1 exits the dialogue
var curent_node_name # name of the speaker
var curent_node_text # dialogue text
var curent_node_next_id # connect to the next node Note: ignored if curent_node_choices has things inside
var curent_node_choices = [] # If you want more than one possible answear, you should fill this up

var force = false # force start the dialogue
var random = false # Start from random node

#------UI--------#
onready var dialogueText = $DialogueText
onready var dialoguePanel = self #Less rewritting if you want to move the script to another object
onready var dialogueName = $DialogueName
onready var dialogueButtons = [$Control/ContinueBtn,$Control/DialogueButton2,$Control/DialogueButton3,$Control/DialogueButton4]




func _ready():
	rand_seed(OS.get_unix_time())
	#----HERE FOR PREVIEW----#

#	LoadFile(file_name)
#	StartDialogue()



func LoadFile(fname):
	file_name = fname
	var file = File.new()
	if file.file_exists("res://Dialogues/"+file_name):
		file.open("res://Dialogues/" + file_name, file.READ)
		var json_result = parse_json(file.get_as_text())
		force = bool(json_result["Force"])
		random = bool(json_result["Random"])
		curent_node_id = 0
		nodes = json_result["Nodes"]

	else:
		print("Dialogue: File Open Error")
	file.close()

	print("File loaded")

	if force:
		StartDialogue()

#-----Traversing Graph-----#
func StartDialogue():
	if nodes:
		if random:
			var temp = []
			for x in nodes:
				temp.append(x["id"])
			curent_node_id = temp[randi()%temp.size()]
		else:
			curent_node_id = 0
		HandleNode()
	else:
		print("Dialogue: Could not Find Nodes")

func EndDialogue():
	curent_node_id = -1

func NextNode(id):
	curent_node_id = id
	HandleNode()

#----Handle Current Node-----#
func HandleNode():
	if curent_node_id < 0 :
		EndDialogue()
	else:
		if !GrabNode(curent_node_id):
			EndDialogue()
	UpdateUI()

func GrabNode(id):
	for node in nodes:
		if int(node["id"]) == id:
			curent_node_name = node["name"]
			curent_node_text = node["text"]
			curent_node_next_id = int(node["next_id"])
			curent_node_choices = node["choices"]
			return true
	return false

#----Update UI-----#
func UpdateUI():
	if curent_node_id >= 0:
		dialoguePanel.show()
		for x in dialogueButtons:
			x.hide()
			#disconnect buttons
			if dialogueButtons[0].is_connected("pressed",self,"_on_Button_Pressed"):
				dialogueButtons[0].disconnect("pressed",self,"_on_Button_Pressed")


		dialogueName.bbcode_text = curent_node_name
		dialogueText.bbcode_text = curent_node_text

		if curent_node_choices.size() > 0:
			for x in clamp(curent_node_choices.size(),0,3):
				dialogueButtons[x+1].get_node("Label").text = curent_node_choices[x]["text"]

				#connecto to button
				dialogueButtons[x+1].connect("pressed",self,"_on_Button_Pressed", [curent_node_choices[x]["next_id"]])

				dialogueButtons[x+1].show()

		else:
			dialogueButtons[0].get_node("Label").text = "OK"
			dialogueButtons[0].show()
			#connect to the button
			dialogueButtons[0].connect("pressed",self,"_on_Button_Pressed", [curent_node_next_id])

	else:
		dialoguePanel.hide()

#-----On Button Pressed-----#
func _on_Button_Pressed(id):
	NextNode(id)
