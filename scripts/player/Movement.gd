extends Node

signal dashing

func move(inputs, motion, speed, jumpForce, gravity, windResistance, dashForce, direction, isOnFloor, isOnCeiling, isOnWall, duckLock, dashing):
	if inputs == null:
		return
	
	var left = inputs["left"]
	var right = inputs["right"]
	var jump = inputs["jump"]
	var duck = inputs["duck"]
	var grab = inputs["grab"]
	var dash = inputs["dash"]
	
	if dashing:
		motion.y = 0
		if direction == "right":
			motion.x -= windResistance * 20
			if motion.x < dashForce/4:
				dashing = false
		elif direction == "left":
			motion.x += windResistance * 20
			if motion.x > -dashForce/4:
				dashing = false
		emit_signal("dashing", dashing)
		return {
		"motion": motion, 
		"direction": direction,
		}
	
	if isOnFloor:
		if duck or duckLock:
			speed = speed/2
		if left:
			direction = "left"
			motion.x = -speed
		elif right:
			direction = "right"
			motion.x = speed
		else:
			motion.x = 0
		motion.y = gravity
		if jump:
			motion.y = -jumpForce
	elif not isOnFloor:
		if not dashing:
			if motion.x > 0:
				motion.x -= windResistance
			elif motion.x < 0:
				motion.x += windResistance
			motion.y += gravity
			if isOnCeiling:
				motion.y = gravity
			
	
	if isOnWall:
		if direction == "right":
			motion.x = 1
		elif direction == "left":
			motion.x = -1
		if grab:
			motion.y = 0
		
		if jump:
			if direction == "right":
				motion.x = -speed
				direction = "left"
			elif direction == "left":
				motion.x = speed
				direction = "right"
			motion.y = -jumpForce
	
	if dash:
		dashing = true
		if direction == "right":
			motion.x = dashForce
		elif direction == "left":
			motion.x = -dashForce
		emit_signal("dashing", dashing)
	
	return {
		"motion": motion, 
		"direction": direction,
		}
