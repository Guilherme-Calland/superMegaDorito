extends AudioStreamPlayer

var runAudioUnlocked = false
var runAudioLock2Unlocked = true
var landingAudioUnlocked = false
var wallTouchAudioUnlocked = false
var ceilingTouchAudioUnlocked = false

var isOnFloor
var isOnWall
var isOnCeiling
var dashFloorStop

var terrain = "grass"
var key = "middle"

var woodAudioPaths = {
	0 : "res://audio/player/wood/0.ogg",
	1 : "res://audio/player/wood/1.ogg",
	2 : "res://audio/player/wood/2.ogg",
	3 : "res://audio/player/wood/3.ogg",
	4 : "res://audio/player/wood/4.ogg",
	5 : "res://audio/player/wood/5.ogg",
	6 : "res://audio/player/wood/6.ogg",
	7 : "res://audio/player/wood/7.ogg",
	8 : "res://audio/player/wood/8.ogg"
}

var grassAudioPaths = {
	0 : "res://audio/player/grass/0.ogg",
	1 : "res://audio/player/grass/1.ogg",
	2 : "res://audio/player/grass/2.ogg",
	3 : "res://audio/player/grass/3.ogg",
	4 : "res://audio/player/grass/4.ogg",
	5 : "res://audio/player/grass/5.ogg",
	6 : "res://audio/player/grass/6.ogg",
	7 : "res://audio/player/grass/7.ogg",
	8 : "res://audio/player/grass/8.ogg",
}

var metalAudioPaths = {
	0 : "res://audio/player/metal/0.ogg",
	1 : "res://audio/player/metal/1.ogg",
	2 : "res://audio/player/metal/2.ogg",
	3 : "res://audio/player/metal/3.ogg",
	4 : "res://audio/player/metal/4.ogg",
	5 : "res://audio/player/metal/5.ogg",
	6 : "res://audio/player/metal/6.ogg",
	7 : "res://audio/player/metal/7.ogg"
}

var bongoAudioPaths = {
	0 : "res://audio/player/bongo/bongoA.ogg",
	1 : "res://audio/player/bongo/bongoB.ogg",
	2 : "res://audio/player/bongo/bongoC.ogg",
	3 : "res://audio/player/bongo/bongoD.ogg",
	4 : "res://audio/player/bongo/bongoE.ogg",
	5 : "res://audio/player/bongo/bongoF.ogg",
	6 : "res://audio/player/bongo/bongoG.ogg"
}

var tamborineAudioPaths = {
	"middle" : "res://audio/player/tamborine/tamborine1.ogg",
	"side" : "res://audio/player/tamborine/tamborine2.ogg"
}

var pianoAudioPaths = {
	"c" : "res://audio/player/keys/piano/c.ogg",
	"cSh" : "res://audio/player/keys/piano/csh.ogg",
	"d" : "res://audio/player/keys/piano/d.ogg",
	"dSh" : "res://audio/player/keys/piano/dsh.ogg",
	"e" : "res://audio/player/keys/piano/e.ogg",
	"f" : "res://audio/player/keys/piano/f.ogg",
	"fSh" : "res://audio/player/keys/piano/fsh.ogg",
	"g" : "res://audio/player/keys/piano/g.ogg",
	"gSh" : "res://audio/player/keys/piano/gsh.ogg",
	"a" : "res://audio/player/keys/piano/a.ogg",
	"aSh" : "res://audio/player/keys/piano/ash.ogg",
	"b" : "res://audio/player/keys/piano/b.ogg",
	"c8" : "res://audio/player/keys/piano/c8.ogg",
	"c8Sh" : "res://audio/player/keys/piano/c8sh.ogg"
}

var keyboardAudioPaths = {
	"c" : "res://audio/player/keys/keyboard/c.ogg",
	"cSh" : "res://audio/player/keys/keyboard/csh.ogg",
	"d" : "res://audio/player/keys/keyboard/d.ogg",
	"dSh" : "res://audio/player/keys/keyboard/dsh.ogg",
	"e" : "res://audio/player/keys/keyboard/e.ogg",
	"f" : "res://audio/player/keys/keyboard/f.ogg",
	"fSh" : "res://audio/player/keys/keyboard/fsh.ogg",
	"g" : "res://audio/player/keys/keyboard/g.ogg",
	"gSh" : "res://audio/player/keys/keyboard/gsh.ogg",
	"a" : "res://audio/player/keys/keyboard/a.ogg",
	"aSh" : "res://audio/player/keys/keyboard/ash.ogg",
	"b" : "res://audio/player/keys/keyboard/b.ogg",
	"c8" : "res://audio/player/keys/keyboard/c8.ogg",
	"c8Sh" : "res://audio/player/keys/keyboard/c8sh.ogg"
}

func emitAudio(sprite, flags):
	unpackBundle(flags)
	handleRunAudio(sprite)
	handleCollisionAudio()
	if dashFloorStop:
		playTerrainAudio()

func unpackBundle(flags):
	isOnFloor = flags["isOnFloor"]
	isOnWall = flags["isOnWall"]
	isOnCeiling = flags["isOnCeiling"]
	dashFloorStop = flags["dashFloorStop"]

func handleFloorCollisionAudio():
	if not isOnFloor:
		landingAudioUnlocked = true
	elif isOnFloor:
		if landingAudioUnlocked:
			landingAudioUnlocked = false
			playTerrainAudio()
			
func handleWallCollisionAudio():
	if not isOnWall:
		wallTouchAudioUnlocked = true
	elif isOnWall:
		if wallTouchAudioUnlocked:
			wallTouchAudioUnlocked = false
			playTerrainAudio()
			
func handleCeilingCollisionAudio():
	if not isOnCeiling:
		ceilingTouchAudioUnlocked = true
	elif isOnCeiling:
		if ceilingTouchAudioUnlocked:
			ceilingTouchAudioUnlocked = false
			playTerrainAudio()
			
func handleRunAudio(sprite):
	if sprite.animation == "run":
		var frame = sprite.get_frame()
		if frame == 2:
			runAudioUnlocked = true
		#so that the first frame or running no audio is played
		if runAudioUnlocked:
			if frame%2 == 0:
				#so that the audio only plays once
				if runAudioLock2Unlocked:
					runAudioLock2Unlocked = false
					playTerrainAudio()
			else:
				runAudioLock2Unlocked = true
	else:
		runAudioUnlocked = false
		runAudioLock2Unlocked = true
		
func handleCollisionAudio():
	handleFloorCollisionAudio()
	handleWallCollisionAudio()
	handleCeilingCollisionAudio()
	
func playTerrainAudio():
	var generator = RandomNumberGenerator.new()
	generator.randomize()
	var randNum
	if terrain == "wood":
		randNum = generator.randf_range(0, 9) as int
		volume_db = 0
		pitch_scale = 2
		stream = load(woodAudioPaths[randNum]) 
	elif terrain == "grass":
		randNum = generator.randf_range(0, 9) as int
		volume_db = -10
		pitch_scale = 1
		stream = load(grassAudioPaths[randNum]) 
	elif terrain == "metal":
		randNum = generator.randf_range(0, 8) as int
		volume_db = 0
		pitch_scale = 1
		stream = load(metalAudioPaths[randNum])
	elif terrain == "bongo":
		volume_db = 0
		pitch_scale = 1
		randNum = generator.randf_range(0,7) as int
		stream = load(bongoAudioPaths[randNum])
	elif terrain == "tamborine":
		volume_db = 0
		pitch_scale = 1
		stream = load(tamborineAudioPaths[key])
	elif terrain == "piano":
		volume_db = 0
		pitch_scale = 1
		stream = load(pianoAudioPaths[key])
	elif terrain == "keyboard":
		volume_db = 0
		pitch_scale = 1
		stream = load(keyboardAudioPaths[key])
	play()

func changeTerrain(t, k):
	terrain = t
	key = k
