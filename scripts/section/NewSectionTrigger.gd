extends Area2D

signal cameraMove
signal collisionEnable
signal sectionCreate
signal sectionDestroy


func _on_NewSectionTrigger_body_entered(body, cameraPos, sectionCreate, sectionDestroy):
	emit_signal("cameraMove", cameraPos)
	emit_signal("collisionEnable")
	createSection(sectionCreate)
	emit_signal("sectionDestroy", sectionDestroy)
	queue_free()

func createSection(sectionNum):
	var section = load("res://scenes/level/levelOne/Section" + str(sectionNum) + ".tscn").instance()
	emit_signal("sectionCreate", section, sectionNum)
	
