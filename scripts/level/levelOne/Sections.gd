extends Node2D

func createSection(section):
	var scene
	if section == 2:
		scene = preload("res://scenes/level/levelOne/Section2.tscn").instance()
		$Section2Position.call_deferred("add_child", scene)
