extends Area2D

signal moveCamera
signal collisionEnable

func _on_NewSectionTrigger_body_entered(body, cameraPos):
	emit_signal("moveCamera", cameraPos)
	emit_signal("collisionEnable")
