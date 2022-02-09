extends Node

func animate(inputs, spriteNormal, spriteTired, isOnFloor, isOnWall, direction, duckLock, dashing, tired, dying):
	if inputs == null:
		return
	var sprite
	
	if dying:
		spriteNormal.show()
		spriteTired.hide()
		sprite = spriteNormal
		sprite.play("die")
		return
	
	if not tired:
		spriteNormal.show()
		spriteTired.hide()
		sprite = spriteNormal
		if direction == "right":
			sprite.flip_h = false
		elif direction == "left":
			sprite.flip_h = true
	else:
		spriteNormal.hide()
		spriteTired.show()
		sprite = spriteTired
		if direction == "left":
			sprite.flip_h = true
		elif direction == "right":
			sprite.flip_h = false
	
	var left = inputs["left"]
	var right = inputs["right"]
	var duck = inputs["duck"]
	var grab = inputs["grab"]
	var jump = inputs["jump"]
	
	if dashing:
		if direction == "left" or direction == "right":
			sprite.play("dashHorizontal")
		elif direction == "up":
			sprite.play("dashUp")
		elif direction == "down":
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
			if isOnFloor:
				sprite.play("duckTouch")
	
		if jump:
			sprite.flip_h = not sprite.flip_h
	elif not isOnFloor:
		sprite.play("jump")
		
	
