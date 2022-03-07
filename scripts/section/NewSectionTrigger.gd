extends Area2D

signal cameraMove
signal collisionEnable
signal sectionCreate
signal sectionDestroy


func _on_NewSectionTrigger_body_entered(body, cameraPos, sectionCreate, sectionDestroy):
	emit_signal("cameraMove", cameraPos)
	emit_signal("collisionEnable")
	createSection(sectionCreate)
	if sectionDestroy != -1:
		emit_signal("sectionDestroy", sectionDestroy)
	queue_free()

func createSection(sectionNum):
	var newSectionPosition = get_node('../NewSectionPosition').global_position
	var newSection = load("res://scenes/level/levelOne/Section" + str(sectionNum) + ".tscn").instance()
	newSection.global_position = newSectionPosition
	emit_signal("sectionCreate", newSection)
	
