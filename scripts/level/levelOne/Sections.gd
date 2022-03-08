extends Node2D

func createSection(section):
	call_deferred("add_child", section, true)

func destroySection(sectionNum):
	var section =  get_child(sectionNum-1)
	section.queue_free()
