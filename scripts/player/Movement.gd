extends Node

#inputs
var leftPressed
var rightPressed
var jumpPressed
var grabPressed
#physics
var motion
var gravity
var speed
var jumpForce
#flags
var isOnFloor
var isOnWall
var isOnCeiling
var facingLeft
var wallJumpLock

#signals
signal facingLeft
signal motion
signal wallJumpLock

func move(bundle):
	unpackBundle(bundle)
	
	if isOnWall:
		if jumpPressed:
			wallJumpLock = true
			emit_signal("wallJumpLock", true)
			motion.y = -jumpForce
			if facingLeft:
				emit_signal("facingLeft", false)
				facingLeft = false
				motion.x = speed
			else:
				facingLeft = true
				emit_signal("facingLeft", true)
				motion.x = -speed
		elif grabPressed:
			motion.y = 0
			emit_signal("motion", motion)
			return
		emit_signal("motion", motion)
		
	handleHorizontalPhysics()
	handleVerticalPhysics()
	emit_signal("motion", motion)
	
func unpackBundle(bundle):
	var inputs = bundle["inputs"]
	var physics = bundle["physics"]
	var flags = bundle["flags"]
	#inputs
	leftPressed = inputs["left"]
	rightPressed = inputs["right"]
	jumpPressed = inputs["jump"]
	grabPressed = inputs["grab"]
	#physics
	motion = physics["motion"]
	gravity = physics["gravity"]
	speed = physics["speed"]
	jumpForce = physics["jumpForce"]
	#flags
	isOnFloor = flags["isOnFloor"]
	isOnWall = flags["isOnWall"]
	isOnCeiling = flags["isOnCeiling"]
	facingLeft = flags["facingLeft"]
	wallJumpLock = flags["wallJumpLock"]

func handleHorizontalPhysics():
	if wallJumpLock:
		return
	if leftPressed:
		motion.x = -speed
		facingLeft = true
		emit_signal("facingLeft", true)
	elif rightPressed:
		motion.x = speed
		facingLeft = false
		emit_signal("facingLeft", false)
	else:
		motion.x = 0

func handleVerticalPhysics():
	if isOnFloor:
		motion.y = gravity
		if jumpPressed:
			motion.y = -jumpForce
	elif not isOnFloor:
		motion.y += gravity
	if isOnCeiling:
		motion.y = gravity
	if motion.y >= 0:
		emit_signal("wallJumpLock", false)

func handleWallPhysics():
	motion.y = 0
	if jumpPressed:
		emit_signal("wallJumpLock", true)
		motion.y = -jumpForce
		if facingLeft:
			motion.x = speed
			emit_signal("facingLeft", false)
		else:
			motion.x = -speed
			emit_signal("facingLeft", true)
	emit_signal("motion", motion)
	return

func grabbingWall():
	return isOnWall and grabPressed
