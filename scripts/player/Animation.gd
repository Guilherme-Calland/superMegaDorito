extends Node

var sprite
#inputs
var grabPressed
#flags
var isOnFloor
var isOnWall
var facingLeft
#physics
var motion


func animate(sprite, bundle):
	init(sprite, bundle)
	
	handleFlipHorizontalAnimation()
	
	if isOnWall:
		handleWallAnimation()
	elif isOnFloor:
		handleFloorAnimation()
	else:
		sprite.play("jump")
	
func init(inSprite, bundle):
	sprite = inSprite
	unpackBundle(bundle)

func handleFlipHorizontalAnimation():
	if facingLeft:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func handleWallAnimation():
	if grabPressed:
		sprite.play("grab")
	elif isOnFloor:
		sprite.play("touchIdle")
	elif not isOnFloor:
		sprite.play("touch")

func handleFloorAnimation():
	if isOnFloor:
		if motion.x != 0:
			sprite.play("run")
		else:
			sprite.play("idle")
		
func unpackBundle(bundle):
	var inputs = bundle["inputs"]
	var physics = bundle["physics"]
	var flags = bundle["flags"]
	#inputs
	grabPressed = inputs["grab"]
	#physics
	motion = physics["motion"]
	#flags
	isOnFloor = flags["isOnFloor"]
	isOnWall = flags["isOnWall"]
	facingLeft = flags["facingLeft"]
