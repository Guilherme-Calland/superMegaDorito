extends Node2D

onready var placeholderTrack = $PlaceholderTrack
onready var track0 = $Pos0/Track0
onready var track1 = $Pos1/Track1
onready var track2 = $Pos2/Track2

func _ready():
	$PlaceholderTrack.play()

func _process(delta):
	$Player.play()
	if Input.is_action_just_pressed("pos0"):
		$Player.position = $Pos0/Pos.global_position
	elif Input.is_action_just_pressed("pos1"):
		$Player.position = $Pos1/Pos.global_position
	elif Input.is_action_just_pressed("pos2"):
		$Player.position = $Pos2/Pos.global_position

func _on_AddTrack0_body_entered(body):
	if not track0.playing:
		var pos = placeholderTrack.get_playback_position()
		track0.play(pos)

func _on_RemoveTrack0_body_entered(body):
	track0.stop()

func _on_AddTrack1_body_entered(body):
	if not track1.playing:
		var pos = placeholderTrack.get_playback_position()
		track1.play(pos)

func _on_RemoveTrack1_body_entered(body):
	track1.stop()
	
func _on_AddTrack2_body_entered(body):
	if not track2.playing:
		var pos = placeholderTrack.get_playback_position()
		track2.play(pos)

func _on_RemoveTrack2_body_entered(body):
	track2.stop()
