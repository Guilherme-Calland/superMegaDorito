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
var jumpLock = false
var dashing = false
var tired = false
var areaType

func _ready():
	$Inputs.connect("ducking", self, "changeCollision")
	$Movement.connect("dashing", self,  "onDashSignal")
	$Movement.connect("jumpLock", self, "onWallJump")
	$Movement.connect("sfx", self, "playAudio")
	
func play():
	$Sound.areaType = areaType
	inputs = $Inputs.retrieveInput()
	var motionBundle = $Movement.move(
		inputs,
		motion,
		speed, jumpForce, gravity, windResistance, dashForce,
		direction, dashDirection,
		is_on_floor(), is_on_ceiling(), is_on_wall(), 
		duckLock, dashing, tired, jumpLock, dying)
	motion = motionBundle["motion"]
	direction = motionBundle["direction"]
	$Animation.animate(
		inputs, 
		$AnimatedSpriteNormal, $AnimatedSpriteTired, 
		is_on_floor(), is_on_wall(), 
		direction, dashDirection,
		duckLock, dashing, tired, dying)
	move_and_slide(motion, Vector2(0,-1))
	if is_on_floor():
		tired = false

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

func onDashSignal(d, dd):
	dashDirection = dd
	dashing = d
	if dashing:
		tired = true

func onWallJump(b):
	jumpLock = b
	
func die():
	dying = true

func playAudio(sfx, intensity):
	$Sound.playAudio(sfx, intensity)
