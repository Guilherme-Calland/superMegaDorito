extends Node

signal dashing
signal onJump
signal onDash
signal wallJumpLock
signal sfx
signal landed

func move(inputs, motion, speed, jumpForce, gravity, windResistance, dashForce, direction, dashDirection, isOnFloor, isOnCeiling, isOnWall, duckLock, dashing, tired, wallJumpLock, dying):
	if inputs == null:
		return
	
	if dying:
		motion = Vector2(0,0)
		return {
		"motion": motion, 
		"direction": direction
		}
	
	var left = inputs["left"]
	var right = inputs["right"]
	var jump = inputs["jump"]
	var duck = inputs["duck"]
	var grab = inputs["grab"]
	var dash = inputs["dash"]
	var up = inputs["up"]
	var down = inputs["down"]
	
	if dashing:
		if dashDirection == "right":
			motion.y = 0
			motion.x -= 10
			if isOnWall:
				motion.x = 1
				dashing = false
			if motion.x < dashForce/4:
				dashing = false
		elif dashDirection == "left":
			motion.y = 0
			motion.x += 10
			if isOnWall:
				motion.x = -1
				dashing = false
			if motion.x > -dashForce/4:
				dashing = false
		else:
			motion.x = 0
			motion.y += 10
			if dashDirection == "up":
				if isOnCeiling:
					motion.y = gravity
					dashing = false
				if motion.y >= -dashForce/4:
					dashing = false
			elif dashDirection == "down":
				if isOnFloor:
					dashing = false
		emit_signal("wallJumpLock", false)
		emit_signal("dashing", dashing, dashDirection)
		
		return {
		"motion": motion, 
		"direction": direction
		}
	
	if isOnFloor:
		emit_signal("landed")
		emit_signal("jumpLock", false)
		if motion.y > gravity:
			if motion.y > 2*jumpForce:
				emit_signal("sfx", "land")
			elif motion.y > jumpForce:
				emit_signal("sfx", "land")
			else: 
				emit_signal("sfx", "land")
		
		if duck or duckLock:
			speed = speed/2
		motion.y = gravity
		if jump:
			motion.y = -jumpForce
			emit_signal("onJump")
	
	if (not isOnWall or not grab) and not wallJumpLock:
		if left:
			direction = "left"
			motion.x = -speed
			if isOnFloor and not isOnWall:
				emit_signal("sfx", "run")
		elif right:
			direction = "right"
			motion.x = speed
			if isOnFloor and not isOnWall:
				emit_signal("sfx", "run")
			
		else:
			motion.x = 0
	
	if not isOnFloor:
		if not dashing:
			if motion.x > 0:
				motion.x -= windResistance
			elif motion.x < 0:
				motion.x += windResistance
			motion.y += gravity
			if isOnCeiling:
				motion.y = gravity
		if motion.y >= gravity*8:
			emit_signal("wallJumpLock", false)
	
	if isOnWall:
		if direction == "right":
			motion.x = 1
		elif direction == "left":
			motion.x = -1
		if grab:
			motion.y = 0
		
		if jump:
			emit_signal("wallJumpLock", true)
			emit_signal("onJump")
			if direction == "right":
				motion.x = -speed
				direction = "left"
			elif direction == "left":
				motion.x = speed
				direction = "right"
			motion.y = -jumpForce
	
	if dash and not tired:
		dashing = true
		if up: 
			motion.y = -dashForce
			dashDirection = "up"
		elif down:
			motion.y = dashForce
			dashDirection = "down"
		elif left:
			direction = "left"
			dashDirection = "left"
			motion.x = -dashForce
		elif right:
			direction = "right"
			dashDirection = "right"
			motion.x = dashForce
		else:
			if direction == "right":
				dashDirection = "right"
				motion.x = dashForce
			elif direction == "left":
				dashDirection = "left"
				motion.x = -dashForce
		emit_signal("dashing", dashing,  dashDirection)
		emit_signal("onDash")
	
	return {
		"motion": motion, 
		"direction": direction
		}
