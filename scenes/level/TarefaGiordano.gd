extends Node2D

onready var placeholderTrack = $PlaceholderTrack
onready var placeholderTrackLong = $PlaceholderTrackLong
onready var track0 = $Pos0/Track
onready var track1 = $Pos1/Track
onready var track2 = $Pos2/Track
onready var track3 = $Pos3/Track
onready var track4 = $Pos4/Track

func _ready():
	placeholderTrack.play()
	placeholderTrackLong.play()

func _process(delta):
	$Player.play()
	if Input.is_action_just_pressed("pos0"):
		$Player.position = $Pos0/Pos.global_position
	elif Input.is_action_just_pressed("pos1"):
		$Player.position = $Pos1/Pos.global_position
	elif Input.is_action_just_pressed("pos2"):
		$Player.position = $Pos2/Pos.global_position
	elif Input.is_action_just_pressed("pos3"):
			$Player.position = $Pos3/Pos.global_position
			
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
		var pos = placeholderTrackLong.get_playback_position()
		track2.play(pos)

func _on_RemoveTrack2_body_entered(body):
	track2.stop()

func _on_AddTrack3_body_entered(body):
	if not track3.playing:
		track3.volume_db = 10
		var pos = placeholderTrackLong.get_playback_position()
		track3.play(pos)

func _on_RemoveTrack3_body_entered(body):
	track3.stop()

func _on_AddTrack4_body_entered(body):
	if not track4.playing:
		var pos = placeholderTrackLong.get_playback_position()
		track4.play(pos)

func _on_RemoveTrack4_body_entered(body):
	track4.stop()
