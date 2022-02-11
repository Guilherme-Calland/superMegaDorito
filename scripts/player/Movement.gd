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

func move(bundle):
	unpackBundle(bundle)
	
	if leftPressed:
		motion.x = -speed
	elif rightPressed:
		motion.x = speed
	else:
		motion.x = 0
	
	if isOnFloor:
		motion.y = gravity
		if jumpPressed:
			motion.y = -jumpForce
	else:
		motion.y += gravity
	
	return motion
	
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
