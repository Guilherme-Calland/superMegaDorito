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
var dashing
var dashReady
#signals
signal facingLeft
signal motion
signal wallJumpLock
signal dashing
signal dashReady
signal dashFloorStop
signal onDash

func move(bundle):
	emit_signal("dashFloorStop", false)
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
	dashing = flags["dashing"]

func handleHorizontalPhysics():
	if dashPressed and dashReady and not isOnWall:
		emit_signal("onDash")
		dashReady = false
		emit_signal("dashReady", false)
		dashing = true
		emit_signal("dashing", true) 
		if facingLeft:
			motion.x = -dashForce
		else:
			motion.x = dashForce
		emit_signal("motion", motion)
		return true
	
	if dashing:
		motion.y = 0
		if facingLeft:
			motion.x += gravity
			if motion.x >= 0:
				dashing = false
				emit_signal("dashing", false)
		else:
			motion.x -= gravity
			if motion.x <= 0:
				dashing = false
				emit_signal("dashing", false)
		if not dashing and isOnFloor:
			emit_signal("dashFloorStop", true)
		emit_signal("motion", motion)
		return true
	
	if wallJumpLock:
		return false
	
	if leftPressed:
		facingLeft = true
		emit_signal("facingLeft", true)
		motion.x = -speed
	elif rightPressed:
		facingLeft = false
		emit_signal("facingLeft", false)
		motion.x = speed
	else:
		motion.x = 0
	
func handleVerticalPhysics():
	if isOnFloor:
		motion.y = gravity
		if jumpPressed:
			motion.y = -jumpForce
		dashing = false
		dashReady = true
		emit_signal("wallJumpLock", false)
	elif not isOnFloor:
		motion.y += gravity
	if isOnCeiling:
		motion.y = gravity

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
	if motion.y >= 0 and (rightPressed or leftPressed or isOnWall):
		emit_signal("wallJumpLock", false)
		
func grabbingWall():
	return isOnWall and grabPressed
