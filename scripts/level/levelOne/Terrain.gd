extends Node2D

func destroyArea(area):
	if area == 1:
		$Area1.queue_free()
	elif area == 2:
		$Area2.queue_free()

func instanciateArea(area):
	if area == 3:
		var area3 = preload("res://scenes/level/levelOne/Area3.tscn").instance()
		$Area2.add_child(area3)
