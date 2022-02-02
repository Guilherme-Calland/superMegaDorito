extends Node

func move(inputs, motion, speed, jumpForce, gravity, isOnFloor, isOnCeiling, isOnWall, duckLock):
	if inputs == null:
		return
	
	var left = inputs["left"]
	var right = inputs["right"]
	var jump = inputs["jump"]
	var duck = inputs["duck"]
	var grab = inputs["grab"]
	
	if isOnFloor:
		if duck or duckLock:
			speed = speed/2
		if left:
			motion.x = -speed
		elif right:
			motion.x = speed
		else:
			motion.x = 0
		motion.y = gravity
		if jump:
			motion.y = -jumpForce
	elif not isOnFloor:
		motion.y += gravity
		if isOnCeiling:
			motion.y = gravity
			
	if isOnWall:
		if motion.x > 0:
			motion.x = 1
		elif motion.x < 0:
			motion.x = -1
		if grab:
			motion.y = 0
		
		if jump:
			if motion.x > 0:
				motion.x = -speed
			elif motion.x < 0:
				motion.x = speed
			motion.y = -jumpForce
		
	return motion
