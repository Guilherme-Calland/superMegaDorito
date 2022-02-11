extends Node

#inputs
var leftPressed
var rightPressed
#physics
var motion
#flags
var isOnFloor

func animate(sprite, bundle):
	unpackBundle(bundle)
	
	if leftPressed:
		sprite.flip_h = true
	elif rightPressed:
		sprite.flip_h = false
	
	if isOnFloor:
		if motion.x != 0:
			sprite.play("run")
		else:
			sprite.play("idle")
	else:
		sprite.play("jump")

func unpackBundle(bundle):
	var inputs = bundle["inputs"]
	var physics = bundle["physics"]
	var flags = bundle["flags"]
	#inputs
	leftPressed = inputs["left"]
	rightPressed = inputs["right"]
	#motion
	motion = physics["motion"]
	#flags
	isOnFloor = flags["isOnFloor"]
