extends Area2D

signal cameraMove
signal sectionCreate
signal sectionDestroy


func _on_NewSectionTrigger_body_entered(body, cameraOffset, sectionCreate, sectionDestroy):
	emit_signal("cameraMove", cameraOffset)
	createSection(sectionCreate)
	if sectionDestroy != -1:
		emit_signal("sectionDestroy", sectionDestroy)
	queue_free()

func createSection(sectionNum):
	var newSectionPosition = get_node('../NewSectionPosition').global_position
	var newSection = load("res://scenes/level/levelOne/Section" + str(sectionNum) + ".tscn").instance()
	newSection.global_position = newSectionPosition
	emit_signal("sectionCreate", newSection)
	
