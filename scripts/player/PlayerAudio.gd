extends AudioStreamPlayer

var onDash
var onJump

var jumpAudioPaths = {
	0 : "res://audio/player/jump/jump1.ogg", 
	1 : "res://audio/player/jump/jump2.ogg",
	2 : "res://audio/player/jump/jump3.ogg",
	3 : "res://audio/player/jump/jump4.ogg",
	4 : "res://audio/player/jump/jump5.ogg",
	5 : "res://audio/player/jump/jump6.ogg",
	6 : "res://audio/player/jump/jump7.ogg",
	7 : "res://audio/player/jump/jump8.ogg",
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
	var generator = RandomNumberGenerator.new()
	generator.randomize()
	var randNum
	randNum = generator.randf_range(0, 8) as int
	stream = load(jumpAudioPaths[randNum])
	play()
