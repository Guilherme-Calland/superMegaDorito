extends AudioStreamPlayer

var onDash
var onJump

var jumpAudioPaths1 = {
	0 : "res://audio/player/jump/my_voice/jump1.ogg",
	1 : "res://audio/player/jump/my_voice/jump2.ogg",
	2 : "res://audio/player/jump/my_voice/jump3.ogg",
	3 : "res://audio/player/jump/my_voice/jump4.ogg",
	4 : "res://audio/player/jump/my_voice/jump5.ogg",
	5 : "res://audio/player/jump/my_voice/jump6.ogg",
	6 : "res://audio/player/jump/my_voice/jump7.ogg",
	7 : "res://audio/player/jump/my_voice/jump8.ogg",
}

var jumpAudioPaths2 = {
	0 : "res://audio/player/jump/normal_jump_sound/jump1.ogg",
	1 : "res://audio/player/jump/normal_jump_sound/jump2.ogg"
}

var dashAudioPath = "res://audio/player/dash/simple_dash.ogg"

func emitAudio(flags, jumpAudioEnabled, dashAudioEnabled):
	unpackBundle(flags)
	if onDash and dashAudioEnabled:
		playDashAudio()
	if onJump and jumpAudioEnabled:
		playJumpAudio()
		
func unpackBundle(flags):
	onDash = flags["onDash"]
	onJump = flags["onJump"]

func playDashAudio():
	stream = load(dashAudioPath)
	play()

func playJumpAudio():
	print("hello1")	
	var generator = RandomNumberGenerator.new()
	generator.randomize()
	var randNum
	randNum = generator.randf_range(0, 2) as int
	stream = load(jumpAudioPaths2[randNum])
	play()
