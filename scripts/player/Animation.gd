extends Node

func animate(inputs, sprite, isOnFloor, isOnWall, duckLock, dashing):
	if inputs == null:
		return
	
	var left = inputs["left"]
	var right = inputs["right"]
	var duck = inputs["duck"]
	var grab = inputs["grab"]
	var jump = inputs["jump"]
	
	if dashing:
		sprite.play("dashHorizontal")
		return
	
	if duckLock:
		if left: 
			sprite.play("duckMove")
			sprite.flip_h = true
		elif right:
			sprite.play("duckMove")
			sprite.flip_h = false
		else:
			sprite.play("duck")
		return
	
	if isOnFloor and not isOnWall:
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
	
	if isOnWall:
		if not duck:
			if not grab:
				if isOnFloor:
					sprite.play("touchIdle")
				else:
					sprite.play("touch")
			elif grab:
				sprite.play("grab")
		elif duck:
			sprite.play("duckTouch")
	
		if jump:
			sprite.flip_h = not sprite.flip_h
	elif not isOnFloor:
		sprite.play("jump")
		
	
