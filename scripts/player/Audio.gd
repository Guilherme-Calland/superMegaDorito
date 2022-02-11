extends AudioStreamPlayer

var runAudioUnlocked = false
var landingAudioUnlocked = false
var wallTouchAudioUnlocked = false
var ceilingTouchAudioUnlocked = false

var isOnFloor
var isOnWall
var isOnCeiling

func emitAudio(sprite, flags):
	unpackBundle(flags)
	
	if sprite.animation == "run":
		var frame = sprite.get_frame()		
		if runAudioUnlocked:
			if not playing:
				stream = load("res://audio/0.ogg")
				if frame%2 == 0:
					play()
		
		if frame == 2:
			runAudioUnlocked = true
	else:
		runAudioUnlocked = false
		
	if not isOnFloor:
		landingAudioUnlocked = true
	elif isOnFloor:
		if landingAudioUnlocked:
			stream = load("res://audio/0.ogg")
			play()
			landingAudioUnlocked = false
			
	if not isOnWall:
		wallTouchAudioUnlocked = true
	elif isOnWall:
		if wallTouchAudioUnlocked:
			stream = load("res://audio/0.ogg")
			play()
			wallTouchAudioUnlocked = false
			
	if not isOnCeiling:
		ceilingTouchAudioUnlocked = true
	elif isOnCeiling:
		if ceilingTouchAudioUnlocked:
			stream = load("res://audio/0.ogg")
			play()
			ceilingTouchAudioUnlocked = false

func unpackBundle(flags):
	isOnFloor = flags["isOnFloor"]
	isOnWall = flags["isOnWall"]
	isOnCeiling = flags["isOnCeiling"]
