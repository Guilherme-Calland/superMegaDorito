extends Node

#inputs
var leftPressed
var rightPressed
var jumpPressed
var grabPressed
var dashPressed
#physics
var motion
var gravity
var speed
var jumpForce
var dashForce
#flags
var isOnFloor
var isOnWall
var isOnCeiling
var facingLeft
var wallJumpLock
var dashLock
#signals
signal facingLeft
signal motion
signal wallJumpLock
signal dashLock

func move(bundle):
	unpackBundle(bundle)
	var grabbing = handleWallPhysics()
	if grabbing:
		return
	var dashing = handleHorizontalPhysics()
	if dashing:
		return
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
	dashPressed = inputs["dash"]
	#physics
	motion = physics["motion"]
	gravity = physics["gravity"]
	speed = physics["speed"]
	jumpForce = physics["jumpForce"]
	dashForce = physics["dashForce"]
	#flags
	isOnFloor = flags["isOnFloor"]
	isOnWall = flags["isOnWall"]
	isOnCeiling = flags["isOnCeiling"]
	facingLeft = flags["facingLeft"]
	wallJumpLock = flags["wallJumpLock"]
	dashLock = flags["dashLock"]

func handleHorizontalPhysics():
	if wallJumpLock:
		return false
	
	if dashLock:
		motion.y = 0
		if facingLeft:
			motion.x += gravity
			if motion.x >= 0:
				dashLock = false
				emit_signal("dashLock", false)
		else:
			motion.x -= gravity
			if motion.x <= 0:
				dashLock = false
				emit_signal("dashLock", false)
		emit_signal("motion", motion)
		return true
	
	if leftPressed:
		facingLeft = true
		emit_signal("facingLeft", true)
		if dashPressed:
			motion.x = -dashForce
			dashLock = true
			emit_signal("dashLock", true)
		else:
			motion.x = -speed
	elif rightPressed:
		facingLeft = false
		emit_signal("facingLeft", false)
		if dashPressed:
			motion.x = dashForce
			dashLock = true
			emit_signal("dashLock", true)
		else:
			motion.x = speed
	else:
		motion.x = 0

func handleVerticalPhysics():
	if isOnFloor:
		motion.y = gravity
		if jumpPressed:
			motion.y = -jumpForce
		dashLock = false
		emit_signal("dashLock", false)
	elif not isOnFloor:
		motion.y += gravity
	if isOnCeiling:
		motion.y = gravity
	if motion.y >= 0 and (leftPressed or rightPressed or isOnFloor):
		emit_signal("wallJumpLock", false)

func handleWallPhysics():
	if isOnWall:
		if facingLeft:
			motion.x = -1
		else:
			motion.x = 1
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
			return false
		elif grabPressed:
			motion.y = 0
			emit_signal("motion", motion)
			return true
		
func grabbingWall():
	return isOnWall and grabPressed
