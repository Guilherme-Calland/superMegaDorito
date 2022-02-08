extends Node2D


func _ready():
	$Music/MusicTrack1.play()

func _process(delta):
	$Player.play()
	
func _on_CueMusic_body_entered(body):
	$Music/MusicTrack2.play($Music/MusicTrack1.get_playback_position())
