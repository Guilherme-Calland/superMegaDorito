extends KinematicBody2D

#physics
var motion = Vector2(0,0)
export var speed = 10
export var jumpForce = 100
export var gravity = 5
#flags
var facingLeft

var bundle
var inputs
var physics
var flags

func _ready():
	connectToSignals()

func _process(delta):
	updateBundle()
	$Movement.move(bundle)
	$Animation.animate($AnimatedSprite, motion, flags)
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
		"facingLeft" : facingLeft
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

func connectToSignals():
	$Movement.connect("motion", self, "updateMotion")
	$Movement.connect("facingLeft", self, "updateFacingLeft")
