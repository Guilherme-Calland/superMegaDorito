extends AudioStreamPlayer

var runAudioUnlocked = false
var landingAudioUnlocked = false
var wallTouchAudioUnlocked = false
var ceilingTouchAudioUnlocked = false

var isOnFloor
var isOnWall
var isOnCeiling

var woodAudioPath0 = "res://audio/player/wood/0.ogg"
var woodAudioPath1 = "res://audio/player/wood/1.ogg"
var woodAudioPath2 = "res://audio/player/wood/2.ogg"
var woodAudioPath3 = "res://audio/player/wood/3.ogg"
var woodAudioPath4 = "res://audio/player/wood/4.ogg"
var woodAudioPath5 = "res://audio/player/wood/5.ogg"
var woodAudioPath6 = "res://audio/player/wood/6.ogg"
var woodAudioPath7 = "res://audio/player/wood/7.ogg"
var woodAudioPath8 = "res://audio/player/wood/8.ogg"

func emitAudio(sprite, flags):
	unpackBundle(flags)
	handleRunAudio(sprite)
	handleCollisionAudio()

func unpackBundle(flags):
	isOnFloor = flags["isOnFloor"]
	isOnWall = flags["isOnWall"]
	isOnCeiling = flags["isOnCeiling"]

func handleFloorCollisionAudio():
	if not isOnFloor:
		landingAudioUnlocked = true
	elif isOnFloor:
		if landingAudioUnlocked:
			playWoodAudio()
			
func handleWallCollisionAudio():
	if not isOnWall:
		wallTouchAudioUnlocked = true
	elif isOnWall:
		if wallTouchAudioUnlocked:
			wallTouchAudioUnlocked = false
			playWoodAudio()
			
func handleCeilingCollisionAudio():
	if not isOnCeiling:
		ceilingTouchAudioUnlocked = true
	elif isOnCeiling:
		if ceilingTouchAudioUnlocked:
			ceilingTouchAudioUnlocked = false
			playWoodAudio()
			
func handleRunAudio(sprite):
	if sprite.animation == "run":
		var frame = sprite.get_frame()
		if runAudioUnlocked:
			if not playing:
				if frame%2 == 0:
					playWoodAudio()
		if frame == 2:
			runAudioUnlocked = true
	else:
		runAudioUnlocked = false
		
func handleCollisionAudio():
	handleFloorCollisionAudio()
	handleWallCollisionAudio()
	handleCeilingCollisionAudio()
	
func playWoodAudio():
	landingAudioUnlocked = false
	var generator = RandomNumberGenerator.new()
	generator.randomize()
	var randNum = generator.randf_range(0, 9) as int
	var audioPath = woodAudioPath0
	if randNum == 0:
		audioPath = woodAudioPath0
	elif randNum == 1:
		audioPath = woodAudioPath1
	elif randNum == 2:
		audioPath= woodAudioPath2
	elif randNum == 3:
		audioPath == woodAudioPath3
	elif randNum == 4:
		audioPath = woodAudioPath4
	elif randNum == 5:
		audioPath = woodAudioPath5
	elif randNum == 6:
		audioPath = woodAudioPath6
	elif randNum == 7:
		audioPath = woodAudioPath7
	elif randNum == 8:
		audioPath = woodAudioPath8
	stream = load(audioPath) 
	play()
