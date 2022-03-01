extends KinematicBody2D

#physics
var motion = Vector2(0,0)
export var speed = 10
export var jumpForce = 100
export var gravity = 5
export var dashForce = 100

export var playerJumpingAudioEnabled = true
export var playerDashAudioEnabled = true
export var playerTerrainAudioEnabled = true

#flags
var facingLeft
var wallJumpLock
var dashing
var dashReady
var dashFloorStop
var onDash
var onJump
var leftLock
var rightLock

var bundle
var inputs
var physics
var flags

func _ready():
	connectToSignals()

func run():
	updateBundle()
	$Movement.move(bundle)
	# update bundle again so we update the changed values we will still need in this frame
	updateBundle()
	$Animation.animate($AnimatedSprite, bundle)
	$Audio.emitAudio($AnimatedSprite, flags, playerJumpingAudioEnabled, playerDashAudioEnabled, playerTerrainAudioEnabled)
	move_and_slide(motion, Vector2(0,-1))
	setAllOneShotFlagsToFalse()
	
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
		"dashFloorStop" : dashFloorStop,
		"onDash": onDash,
		"onJump" : onJump,
		"leftLock": leftLock,
		"rightLock" : rightLock
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

func onJump():
	onJump = true

func setAllOneShotFlagsToFalse():
	onDash = false
	onJump = false

func connectToSignals():
	$Movement.connect("motion", self, "updateMotion")
	$Movement.connect("facingLeft", self, "updateFacingLeft")
	$Movement.connect("wallJumpLock", self, "updateWallJumpLock")
	$Movement.connect("dashing", self, "updateDashLock")
	$Movement.connect("dashReady", self, "updateDashReady")
	$Movement.connect("dashFloorStop", self, "updateDashFloorStop")
	$Movement.connect("onDash", self, "onDash")
	$Movement.connect("onJump", self, "onJump")

func _on_Terrain_body_entered(body, terrain, key):
	$Audio/AmbientAudio.changeTerrain(terrain, key)

func _on_AreaBarrier_body_entered(body, directionLock):
	if directionLock == "left":
		leftLock = true
	elif directionLock == "right":
		rightLock = true

func _on_AreaBarrier_body_exited(body):
	leftLock = false
	rightLock = false
