extends Node

var sprite
#flags
var isOnFloor
var isOnWall
var facingLeft
#physics
var motion


func animate(sprite, motion, flags):
	init(sprite, motion, flags)
	
	if facingLeft:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	if isOnWall:
		handleWallAnimation()
	elif isOnFloor:
		handleFloorAnimation()
	else:
		sprite.play("jump")
	
func init(inSprite, inMotion, inFlags):
	sprite = inSprite
	motion = inMotion
	unpackBundle(inFlags)

func handleWallAnimation():
	if isOnFloor:
		sprite.play("touchIdle")
	elif not isOnFloor:
		sprite.play("touch")

func handleFloorAnimation():
	if isOnFloor:
		if motion.x != 0:
			sprite.play("run")
		else:
			sprite.play("idle")
		
func unpackBundle(flags):
	#flags
	isOnFloor = flags["isOnFloor"]
	isOnWall = flags["isOnWall"]
	facingLeft = flags["facingLeft"]
