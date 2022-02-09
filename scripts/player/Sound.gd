extends AudioStreamPlayer

var areaType

onready var jumpAudio1Path = "res://sound/soundEffects/jumping/jump1.ogg"
onready var jumpAudio2Path = "res://sound/soundEffects/jumping/jump2.ogg"

var randomNumberGenerator

func _ready():
	randomNumberGenerator = RandomNumberGenerator.new()

func emitAudio(jumping):
	if jumping:
		playJumpAudio()

func playJumpAudio():
	randomNumberGenerator.randomize()
	var rand = randomNumberGenerator.randf_range(0,2) as int
	if rand == 0:
		stream = load(jumpAudio1Path)
	else:
		stream = load(jumpAudio2Path)
	play()

#func playAudio(sfx):
#	if sfx == "jump":
#		volume_db = 0
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#		var rand = rng.randf_range(0,2) as int
#		if rand == 0:
#			stream = load("res://sound/soundEffects/jumping/jump1.ogg")
#		else:
#			stream = load("res://sound/soundEffects/jumping/jump2.ogg")
#		play()
#	elif sfx == "land":
##		if areaType == "grass":
##			stream = load("res://sound/soundEffects/footsteps/grass/grass_0_400ms.ogg")
##			play()
#		stream = load("res://sound/soundEffects/landing/landing1.wav")
#		play()
#	elif sfx == "dash":
#		stream = load("res://sound/soundEffects/dash.wav")
#		play()
#	elif sfx == "run":
#		volume_db = 0
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#		var rand = rng.randf_range(0,9) as int
#		if areaType == "grass":
#			if not playing and rand == 0:
#				stream = load("res://sound/soundEffects/footsteps/grass/grass_0_400ms.ogg")
#				play()
#			if not playing and rand == 1:
#				stream = load("res://sound/soundEffects/footsteps/grass/grass_1_400ms.ogg")
#				play()
#			if not playing and rand == 2:
#				stream = load("res://sound/soundEffects/footsteps/grass/grass_2_400ms.ogg")
#				play()
#			if not playing and rand == 3:
#				stream = load("res://sound/soundEffects/footsteps/grass/grass_3_400ms.ogg")
#				play()
#			if not playing and rand == 4:
#				stream = load("res://sound/soundEffects/footsteps/grass/grass_4_400ms.ogg")
#				play()
#			if not playing and rand == 5:
#				stream = load("res://sound/soundEffects/footsteps/grass/grass_5_400ms.ogg")
#				play()
#			if not playing and rand == 6:
#				stream = load("res://sound/soundEffects/footsteps/grass/grass_6_400ms.ogg")
#				play()
#			if not playing and rand == 7:
#				stream = load("res://sound/soundEffects/footsteps/grass/grass_7_400ms.ogg")
#				play()
#			if not playing and rand == 8:
#				stream = load("res://sound/soundEffects/footsteps/grass/grass_8_400ms.ogg")
#				play()

