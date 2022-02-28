extends Node2D

var generator = RandomNumberGenerator.new() 
	
func _on_Timer_timeout():
	var cloud = preload("res://scenes/background/Cloud.tscn").instance()
	generator.randomize()
	var randNum = generator.randi_range(0, 2)
	if randNum == 0:
		$Pos1.add_child(cloud)
	elif randNum == 1:
		$Pos2.add_child(cloud)
	elif randNum == 2:
		$Pos3.add_child(cloud)

