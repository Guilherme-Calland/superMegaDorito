extends Node

func animate(inputs, sprite, isOnFloor):
	if inputs == null:
		return
	
	var left = inputs["left"]
	var right = inputs["right"]
	var duck = inputs["duck"]
	
	if isOnFloor:
		if left:
			if not duck:
				sprite.play("run")
			elif duck:
				sprite.play("duckMove")
			sprite.flip_h = true
		elif right:
			if not duck:
				sprite.play("run")
			elif duck:
				sprite.play("duckMove")
			sprite.flip_h = false
		else:
			if not duck:
				sprite.play("idle")
			elif duck:
				sprite.play("duck")
	
		
	elif not isOnFloor:
		sprite.play("jump")
