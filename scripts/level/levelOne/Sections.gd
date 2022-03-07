extends Node2D

func createSection(section):
	call_deferred("add_child", section, true)

func destroySection(sectionNum):
	var section =  get_node('Section' + str(sectionNum))
	section.queue_free()
