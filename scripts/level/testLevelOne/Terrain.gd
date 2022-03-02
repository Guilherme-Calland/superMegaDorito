extends Node2D

var area3 = preload("res://scenes/level/testLevelOne/Area3.tscn").instance()
var testScene = preload("res://scenes/player/Player.tscn").instance()

func destroyArea(area):
	if area == 1:
#		$Area1.queue_free()
		pass
	elif area == 2:
		$Area2.queue_free()

func instanciateArea(area):
	if area == 3:
		$Area2.add_child(area3)
