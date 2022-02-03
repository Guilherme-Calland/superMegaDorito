extends Node

func animate(inputs, spriteNormal, spriteTired, isOnFloor, isOnWall, direction, dashDirection, duckLock, dashing, tired):
	if inputs == null:
		return
	var sprite
	if not tired:
		spriteNormal.show()
		spriteTired.hide()
		sprite = spriteNormal
		if direction == "right":
			sprite.flip_h = false
		else:
			sprite.flip_h = true
	else:
		spriteNormal.hide()
		spriteTired.show()
		sprite = spriteTired
		if direction == "left":
			sprite.flip_h = true
		else:
			sprite.flip_h = false
	
	var left = inputs["left"]
	var right = inputs["right"]
	var duck = inputs["duck"]
	var grab = inputs["grab"]
	var jump = inputs["jump"]
	
	if dashing:
		if dashDirection == "left" or dashDirection == "right":
			sprite.play("dashHorizontal")
		elif dashDirection == "up":
			sprite.play("dashUp")
		elif dashDirection == "down":
			sprite.play("dashDown")
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
		
	
