extends Node2D

func createSection(section, sectionNum):
	var sectionParent = get_node('Section' + str(sectionNum))
	sectionParent.call_deferred("add_child", section, true)

func destroySection(sectionNum):
	var section =  get_node('Section' + str(sectionNum))
	section.queue_free()
