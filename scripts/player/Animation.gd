extends Node

#flags
var isOnFloor
var isOnWall
var facingLeft

func animate(sprite, motion, flags):
	unpackBundle(flags)
	
	if facingLeft:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	if isOnWall:
		if isOnFloor:
			sprite.play("touchIdle")
		elif not isOnFloor:
			sprite.play("touch")
	elif isOnFloor:
		if motion.x != 0:
			sprite.play("run")
		else:
			sprite.play("idle")
	else:
		sprite.play("jump")
		
	
func unpackBundle(flags):
	#flags
	isOnFloor = flags["isOnFloor"]
	isOnWall = flags["isOnWall"]
	facingLeft = flags["facingLeft"]
