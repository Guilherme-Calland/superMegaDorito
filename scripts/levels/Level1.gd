extends Node2D

onready var track1 = $Music/MusicTrack1
onready var track2 = $Music/MusicTrack2
onready var track3 = $Music/MusicTrack3

func _ready():
#	track1.play()
	$Player.areaType = "grass"
	pass

func _process(delta):
	$Player.play()
	
func _on_CueMusic_body_entered(body):
#	var track1Position = track1.get_playback_position()
#	track2.play(track1Position)
	pass

func _on_CueMusic2_body_entered(body):
#	var track1Position = track1.get_playback_position()
#	track3.play(track1Position)
	pass
