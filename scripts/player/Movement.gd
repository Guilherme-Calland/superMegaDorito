extends Node

#inputs
var leftPressed
var rightPressed
var jumpPressed
#physics
var motion
var gravity
var speed
var jumpForce
#flags
var isOnFloor

signal motion
signal facingLeft

func move(bundle):
	unpackBundle(bundle)
	handleHorizontalMovement()
	handleVerticalMovement()
	emit_signal("motion", motion)
	
func unpackBundle(bundle):
	var inputs = bundle["inputs"]
	var physics = bundle["physics"]
	var flags = bundle["flags"]
	#inputs
	leftPressed = inputs["left"]
	rightPressed = inputs["right"]
	jumpPressed = inputs["jump"]
	#physics
	motion = physics["motion"]
	gravity = physics["gravity"]
	speed = physics["speed"]
	jumpForce = physics["jumpForce"]
	#flags
	isOnFloor = flags["isOnFloor"]

func handleHorizontalMovement():
	if leftPressed:
		motion.x = -speed
		emit_signal("facingLeft", true)
	elif rightPressed:
		emit_signal("facingLeft", false)
		motion.x = speed
	else:
		motion.x = 0

func handleVerticalMovement():
	if isOnFloor:
		motion.y = gravity
		if jumpPressed:
			motion.y = -jumpForce
	elif not isOnFloor:
		motion.y += gravity
