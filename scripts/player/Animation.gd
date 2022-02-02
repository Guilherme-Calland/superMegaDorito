extends Node

func animate(inputs, sprite, isOnFloor):
	if inputs == null:
		return
	
	var left = inputs["left"]
	var right = inputs["right"]
	
	if isOnFloor:
		if left:
			sprite.play("run")
			sprite.flip_h = true
		elif right:
			sprite.play("run")
			sprite.flip_h = false
		else:
			sprite.play("idle")
	else:
		sprite.play("jump")
