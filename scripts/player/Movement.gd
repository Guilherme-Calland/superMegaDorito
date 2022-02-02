extends Node

func move(inputs, motion, speed, jumpForce, gravity, isOnFloor, isOnCeiling, isOnWall):
	if inputs == null:
		return
	
	var left = inputs["left"]
	var right = inputs["right"]
	var jump = inputs["jump"]
	
	if isOnFloor:
		motion.y = gravity
		if left:
			motion.x = -speed
		elif right:
			motion.x = speed
		else:
			motion.x = 0
		
		if jump:
			motion.y = -jumpForce
	else:
		motion.y += gravity
		
		if isOnWall:
			if motion.x > 0:
				motion.x = 1
			else:
				motion.x = -1
		
		if isOnCeiling:
			motion.y = gravity
	
	return motion
