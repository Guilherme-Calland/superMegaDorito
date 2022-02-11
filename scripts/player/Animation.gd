extends Node

#physics
var motion
#flags
var isOnFloor
var facingLeft

func animate(sprite, motion, flags):
	unpackBundle(flags)
	
	if facingLeft:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	if isOnFloor:
		if motion.x != 0:
			sprite.play("run")
		else:
			sprite.play("idle")
	else:
		sprite.play("jump")

func unpackBundle(flags):
	#flags
	isOnFloor = flags["isOnFloor"]
	facingLeft = flags["facingLeft"]
