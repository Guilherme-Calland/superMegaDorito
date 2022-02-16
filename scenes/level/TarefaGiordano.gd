extends Node

onready var track1 = $Pos0/Track1
onready var track2 = $Pos1/Track2

func _on_AddTrack1_body_entered(body):
	if not track1.playing:
		track1.play()

func _on_RemoveTrack1_body_entered(body):
	track1.stop()

func _on_AddTrack2_body_entered(body):
	if not track2.playing:
		var track1pos = track1.get_playback_position()
		track2.play(track1pos)

func _on_RemoveTrack2_body_entered(body):
	track2.stop()
