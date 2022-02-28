extends Node2D

func _process(delta):
	$Player.run()


func _on_ScenaryBarrier_body_entered(body, lockDirection):
	if lockDirection == "left":
		$Player.leftLock = true
	elif lockDirection == "right":
		$Player.rightLock = true

func _on_ScenaryBarrier_body_exited(body):
	$Player.leftLock = false
	$Player.rightLock = false

