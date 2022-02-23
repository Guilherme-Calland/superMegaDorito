extends KinematicBody2D

#physics
var motion = Vector2(0,0)
export var speed = 10
export var jumpForce = 100
export var gravity = 5
export var dashForce = 100
#flags
var facingLeft
var wallJumpLock
var dashing
var dashReady
var dashFloorStop
var onDash

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
	$Audio/AmbientAudio.emitAudio($AnimatedSprite, flags)
	$Audio/PlayerAudio.emitAudio(onDash)
	move_and_slide(motion, Vector2(0,-1))
	onDash = false
	
func updateBundle():
	inputs = $Inputs.retrieveInput()
	physics = {
		"motion" : motion,
		"speed" : speed,
		"jumpForce" : jumpForce,
		"gravity" : gravity,
		"dashForce" : dashForce
	}
	flags = {
		"isOnFloor" : is_on_floor(),
		"isOnWall" : is_on_wall(),
		"isOnCeiling" : is_on_ceiling(),
		"facingLeft" : facingLeft,
		"wallJumpLock" : wallJumpLock,
		"dashing" : dashing,
		"dashReady" : dashReady,
		"dashFloorStop" : dashFloorStop
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

func updateDashLock(d):
	dashing = d

func updateDashReady(d):
	dashReady = d

func updateDashFloorStop(d):
	dashFloorStop = d

func onDash():
	onDash = true

func connectToSignals():
	$Movement.connect("motion", self, "updateMotion")
	$Movement.connect("facingLeft", self, "updateFacingLeft")
	$Movement.connect("wallJumpLock", self, "updateWallJumpLock")
	$Movement.connect("dashing", self, "updateDashLock")
	$Movement.connect("dashReady", self, "updateDashReady")
	$Movement.connect("dashFloorStop", self, "updateDashFloorStop")
	$Movement.connect("onDash", self, "onDash")

func _on_Terrain_body_entered(body, terrain, key):
	$Audio/AmbientAudio.changeTerrain(terrain, key)
