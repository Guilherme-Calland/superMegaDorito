extends Area2D

signal cameraMove
signal collisionEnable
signal sectionCreate

func _on_NewSectionTrigger_body_entered(body, cameraPos, sectionCreate, sectionDestroy):
	emit_signal("cameraMove", cameraPos)
	emit_signal("collisionEnable")
	emit_signal("sectionCreate", sectionCreate)
