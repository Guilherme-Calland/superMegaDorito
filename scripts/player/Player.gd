extends KinematicBody2D

var inputs
var motion = Vector2(0,0)
export var speed = 10
export var jumpForce = 100
export var gravity = 5
export var windResistance = 1.0
export var dashForce = 200

var direction = "right"
var dashDirection
var duckLock = false
var dashing = false
var tired = false

func _ready():
	$Inputs.connect("ducking", self, "changeCollision")
	$Movement.connect("dashing", self,  "onDashSignal")

func _physics_process(delta):
	inputs = $Inputs.retrieveInput()
	var motionBundle = $Movement.move(
		inputs,
		motion,
		speed, jumpForce, gravity, windResistance, dashForce,
		is_on_floor(), is_on_ceiling(), is_on_wall(), 
		duckLock, dashing, tired)
	motion = motionBundle["motion"]
	direction = motionBundle["direction"]
	$Animation.animate(
		inputs, 
		$AnimatedSpriteNormal, $AnimatedSpriteTired, 
		is_on_floor(), is_on_wall(), 
		direction, dashDirection,
		duckLock, dashing, tired)
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

