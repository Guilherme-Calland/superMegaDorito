extends Node2D

func _process(delta):
	$Player.areaType = "rock"
	$Player.play()
