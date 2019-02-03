extends MeshInstance

signal on_button_1()
signal on_button_2()

export (Color) var color1 = Color(1,1,1,1)
export (Color) var color2 = Color(1,1,1,1)
export (String) var label1 = "nothing"
export (String) var label2 = "nothing"

const TRACKS1 = [ 'HitTheRoadSwing', 'BenTomorrow'  ]
const TRACKS2 = [  'PPCattleDrive', 'PPIronHorse' ]
const TRACKS3 = [ 'bensound-epic']

var TRACKS = [TRACKS1, TRACKS2, TRACKS3]

var TRACKS_SIZE = TRACKS.size()

#Channel de diffusion de la musique
var currentChannel = 0

#Combien de musique sont passee depuis le debut
var counterMusic = [0,0,0]

#AudioStream3D
var musicChannel
var noiseSound
var noiseSound2

#Stock la taille des musiques / le temps OS de départ de des 3 channels de musique
var musicLength = [0.0,0.0,0.0]
var startTime = [0.0, 0.0, 0.0]

#Temps ecoule entre le debut de chaque chanson
var elapsedTime1;
var elapsedTime2;
var elapsedTime3;

#Radio On ou off
var playing = false

#Changement de channel 
var channelChanged = false
var switch_channel = false

#Add noise, depart du bruit pour controler sa duree de diffusion
var start_noise_time = 0
var start_noise_time2 = 0
var noise = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	$Button1.set_color(color1)
	$Button2.set_color(color2)
	$Label1.set_label(label1)
	$Label2.set_label(label2)

	#Randomize pour ne pas tj avoir le meme ordre de musique
	randomize()
	
	#Initialise les channels de musique
	musicChannel = [get_node("MusicChannel1"),get_node("MusicChannel2"),get_node("MusicChannel3")]
	
	#Lance les 3 musiques en stream mais le son est coupe
	for i in range(0,3):
		#musicChannel[i] = get_node(str("MusicChannel",i))
		var rand_nb = randi() % TRACKS[i].size()
		var audiostream = load('res://PisteAudio/radioMusic/' + TRACKS[i][rand_nb] + '.ogg')
		
		musicChannel[i].set_stream(audiostream)
		musicChannel[i].set_unit_db(-80)
		print(musicChannel[i].get_unit_db())
		musicChannel[i].play(0.0)
		startTime[i] = OS.get_ticks_msec()
		counterMusic[i] += 1
		musicLength[i] = audiostream.get_length()
		
		
func _process(delta):
	var time = OS.get_ticks_msec()
	#ADD du bruit sur la musique qui est entrain de passée pendant 4 secondes
	if (time-start_noise_time2)*0.001 > 4 and noise:
		noiseSound2.stop()
		noise = false
		
	#Quand on change de channel on diffuse un bruit de 2 secondes
	if switch_channel:
		var elapsedTimeNoise = time - start_noise_time
		if elapsedTimeNoise *0.001 > 2.0:
			noiseSound.stop()
			switch_channel = false
		if elapsedTimeNoise *0.001 > 1.0 and !channelChanged:
			musicChannel[currentChannel].set_unit_db(10)
			channelChanged = true
	
	#ADD du bruit sur la musique en cours avec une proba de 3 %
	else:
		var proba = randi()%100
		if (proba<3 and !noise and playing):
			noiseSound2 =  get_node("Noise2")
			var audiostream = load('res://PisteAudio/Radio Tuning Sound Effect.ogg')
			var begin_time = randf()*(audiostream.get_length()-5)
			noiseSound2.set_stream(audiostream)
			noiseSound2.play(begin_time)
			start_noise_time2= time
			noise = true
			
	#Mets à jour le time pour savoir combien de temps s'est écoulé depuis le début de chaque musique
	elapsedTime1 = (time - startTime[0]) * 0.001
	elapsedTime2 = (time- startTime[1]) * 0.001
	elapsedTime3 = (time - startTime[2]) * 0.001
	
	#Si temsp écoulé on change la musique		
	if elapsedTime1 >  musicLength[0]:
		_change_music(0)
	if elapsedTime2 >  musicLength[1]:
		_change_music(1)
	if elapsedTime3 >  musicLength[2]:
		_change_music(2)
	pass

#Si on appuie sur le bouton de gauche, on ON / OFF la radio
func _on_Button1_left_click():
	emit_signal("on_button_1")
	if !playing :
		playing = true
		musicChannel[currentChannel].set_unit_db(10)
	else:
		musicChannel[currentChannel].set_unit_db(-80)
		playing = false

#Bouton pour changer de channel
func _on_Button2_left_click():
	emit_signal("on_button_2")
	_changeChannel()

#On change la musique quand celle ci se termine
func _change_music(index):
	if counterMusic[index]%TRACKS[index].size() == 0:
		randomize()
	var rand_nb = randi() % TRACKS[index].size()
	var audiostream = load('res://PisteAudio/radioMusic/' + TRACKS[index][rand_nb] + '.ogg')
	musicChannel[index].set_stream(audiostream)
	musicChannel[index].play(0.0)
	musicLength[index] = audiostream.get_length()
	counterMusic[index] +=1
	
#Changement de channel + ajout du bruit
func _changeChannel():
	musicChannel[currentChannel].set_unit_db(-80)
	currentChannel = (currentChannel+1)%3
	noiseSound =  get_node("Noise1")
	var audiostream = load('res://PisteAudio/Radio Tuning Sound Effect.ogg')
	var begin_time = randf()*(audiostream.get_length()-2)
	noiseSound.set_stream(audiostream)
	noiseSound.play(begin_time)
	start_noise_time = OS.get_ticks_msec()
	switch_channel = true
	channelChanged = false
	

