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

signal facingLeft
signal motion

func move(bundle):
	unpackBundle(bundle)
	if grabbingWall():
		return handleWallPhysics()
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

func handleHorizontalPhysics():
	if leftPressed:
		motion.x = -speed
		emit_signal("facingLeft", true)
	elif rightPressed:
		emit_signal("facingLeft", false)
		motion.x = speed
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

func handleWallPhysics():
	motion.y = 0
	emit_signal("motion", motion)
	return

func grabbingWall():
	return isOnWall and grabPressed
