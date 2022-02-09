extends KinematicBody2D

var inputs
var motion = Vector2(0,0)
export var speed = 10
export var jumpForce = 100
export var gravity = 5
export var windResistance = 1.0
export var dashForce = 200
export var dying = false

var direction = "right"
var dashDirection
var duckLock = false
var wallJumpLock = false
var dashing = false
var onJump = false
var onDash = false
var tired = false
var areaType

func _ready():
	$Inputs.connect("ducking", self, "changeCollision")
	$Movement.connect("dashing", self,  "setDashing")
	$Movement.connect("onJump", self,  "onJump")
	$Movement.connect("wallJumpLock", self, "setWallJumpLock")
	$Movement.connect("landed", self, "onLanding")
	$Movement.connect("onDash", self, "onDash")
#	inputs, motion, speed, jumpForce, dashForce, gravity, windResistance, direction, dashDirection, isOnFloor, isOnWall, isOnCeiling, duckLock, dashing, tired, wallJumpLock, dying
func play():
	$Sound.areaType = areaType
	inputs = $Inputs.retrieveInput()
	var motionBundle = $Movement.move(
		inputs,
		motion,
		speed, jumpForce, dashForce, gravity, windResistance, 
		direction, dashDirection,
		is_on_floor(), is_on_wall(), is_on_ceiling(), 
		duckLock, dashing, tired, wallJumpLock, dying)
	motion = motionBundle["motion"]
	direction = motionBundle["direction"]
	$Animation.animate(
		inputs, 
		$AnimatedSpriteNormal, $AnimatedSpriteTired, 
		is_on_floor(), is_on_wall(), 
		direction, dashDirection,
		duckLock, dashing, tired, dying)
	move_and_slide(motion, Vector2(0,-1))
	$Sound.emitAudio(onJump, onDash)
	onJump = false
	onDash = false

func changeCollision(ducking):
	if ducking and is_on_floor():
		$CollisionStanding.set_deferred("disabled", true)
	else:
		if not duckLock:
			$CollisionStanding.set_deferred("disabled", false)

func _on_TopArea_body_entered(body):
	duckLock = true

func _on_TopArea_body_exited(body):
	duckLock = false
	$CollisionStanding.set_deferred("disabled", false)

func setDashing(d, dd):
	dashDirection = dd
	dashing = d
	if dashing:
		tired = true

func onJump():
	onJump = true

func onDash():
	onDash = true

func setWallJumpLock(b):
	wallJumpLock = b
	
func die():
	dying = true

func onLanding():
	tired = false

