extends KinematicBody2D

#physics
var motion = Vector2(0,0)
export var speed = 10
export var jumpForce = 100
export var gravity = 5
#flags
var facingLeft
var wallJumpLock

var bundle
var inputs
var physics
var flags

func _ready():
	connectToSignals()

func _process(delta):
	updateBundle()
	$Movement.move(bundle)
	$Animation.animate($AnimatedSprite, bundle)
	$Audio.emitAudio($AnimatedSprite, flags)
	move_and_slide(motion, Vector2(0,-1))

func updateBundle():
	inputs = $Inputs.retrieveInput()
	physics = {
		"motion" : motion,
		"speed" : speed,
		"jumpForce" : jumpForce,
		"gravity" : gravity
	}
	flags = {
		"isOnFloor" : is_on_floor(),
		"isOnWall" : is_on_wall(),
		"isOnCeiling" : is_on_ceiling(),
		"facingLeft" : facingLeft,
		"wallJumpLock" : wallJumpLock
	}
	bundle = {
		"inputs" : inputs,
		"physics" : physics,
		"flags" : flags
	}

func updateMotion(m):
	motion = m

func updateFacingLeft(f):
	facingLeft = f

func updateWallJumpLock(w):
	wallJumpLock = w

func connectToSignals():
	$Movement.connect("motion", self, "updateMotion")
	$Movement.connect("facingLeft", self, "updateFacingLeft")
	$Movement.connect("wallJumpLock", self, "updateWallJumpLock")

func _on_GrassArea_body_entered(body):
	$Audio.changeTerrain("grass")

func _on_WoodArea_body_entered(body):
	$Audio.changeTerrain("wood")

func _on_MetalArea_body_entered(body):
	$Audio.changeTerrain("metal")

func _on_BongoArea_body_entered(body):
	$Audio.changeTerrain("bongo")

func _on_TamborineArea_body_entered(body):
	$Audio.changeTerrain("tamborine")

func _on_PianoC_body_entered(body):
	$Audio.changeTerrain("pianoC")
