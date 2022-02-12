extends AudioStreamPlayer

var runAudioUnlocked = false
var landingAudioUnlocked = false
var wallTouchAudioUnlocked = false
var ceilingTouchAudioUnlocked = false

var isOnFloor
var isOnWall
var isOnCeiling

var terrain = "wood"
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
		if runAudioUnlocked:
			if not playing:
				if frame%2 == 0:
					playTerrainAudio()
		if frame == 2:
			runAudioUnlocked = true
	else:
		runAudioUnlocked = false
		
func handleCollisionAudio():
	handleFloorCollisionAudio()
	handleWallCollisionAudio()
	handleCeilingCollisionAudio()
	
func playTerrainAudio():
	var generator = RandomNumberGenerator.new()
	generator.randomize()
	var randNum = generator.randf_range(0, 9) as int
	if terrain == "wood":
		volume_db = 0
		stream = load(woodAudioPaths[randNum]) 
	elif terrain == "grass":
		volume_db = -10
		stream = load(grassAudioPaths[randNum]) 
	play()

func changeTerrain(t):
	terrain = t
