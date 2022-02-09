extends Node

signal dashing
signal onJump
signal onDash
signal wallJumpLock
signal sfx
signal landed

var leftPressed
var rightPressed
var upPressed
var downPressed
var motion
var speed
var jumpForce
var dashForce
var windResistance
var direction 

func move(inputs, motion, speed, jumpForce, dashForce, gravity, windResistance, isOnFloor, isOnWall, isOnCeiling, duckLock, dashing, tired, wallJumpLock, dying):

# inputs, physics, flags
#	onInit(inputs, motion, speed, jumpForce, dashForce, gravity, windResistance, direction,dashDirection, isOnFloor, isOnWall, isOnCeiling, , dashing, tired, dying, duckLock, wallJumpLock)
	
	if inputs == null:
		return
	var left = inputs["left"]
	var right = inputs["right"]
	var jump = inputs["jump"]
	var duck = inputs["duck"]
	var grab = inputs["grab"]
	var dash = inputs["dash"]
	var up = inputs["up"]
	var down = inputs["down"]
	
	if dying:
		return onDying()
	
	if dashing:
		return onDashing(motion, dashForce, gravity, isOnFloor, isOnWall, isOnCeiling, dashing)
	
	if isOnFloor:
		emit_signal("landed")
		emit_signal("wallJumpLock", false)
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
			motion.x = -speed
			if isOnFloor and not isOnWall:
				emit_signal("sfx", "run")
		elif right:
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
		var direction = motionToDirection(motion)
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
			motion = Vector2(0, -dashForce)
		elif down:
			motion = Vector2(0, dashForce)
		elif left:
			motion = Vector2(-dashForce, 0)
		elif right:
			motion = Vector2(dashForce, 0)
		emit_signal("dashing", dashing,  motionToDirection(motion))
		print(motionToDirection(motion))
		emit_signal("onDash")
	
	return {
		"motion": motion, 
		"direction": motionToDirection(motion)
		}


func onDying():
		return {
		"motion": Vector2(0,0), 
		"direction": ""
		}

func onDashing(motion, dashForce, gravity, isOnFloor, isOnWall, isOnCeiling, dashing):
	var direction = motionToDirection(motion)
	if direction == "right":
		motion.y = 0
		motion.x -= 10
		if isOnWall:
			motion.x = 1
			dashing = false
		if motion.x < dashForce/4:
			dashing = false
	elif direction == "left":
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
		if direction == "up":
			if isOnCeiling:
				motion.y = gravity
				dashing = false
			if motion.y >= -dashForce/4:
				dashing = false
		elif direction == "down":
			if isOnFloor:
				dashing = false
	emit_signal("wallJumpLock", false)
	emit_signal("dashing", dashing, motionToDirection(motion))
	
	return {
	"motion": motion, 
	"direction": motionToDirection(motion)
	}

func onInit():
	pass

func motionToDirection(motion):
	if motion.x > 0:
		return "right"
	elif motion.x < 0:
		return "left"
	elif motion.y < 0:
		return "up"
	else:
		return "down"
