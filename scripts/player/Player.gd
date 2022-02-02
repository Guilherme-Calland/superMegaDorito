extends KinematicBody2D

var inputs
var motion = Vector2(0,0)
export var speed = 10
export var jumpForce = 100
export var gravity = 5
var duckLock = false

func _ready():
	$Inputs.connect("ducking", self, "changeCollision")	

func _physics_process(delta):
	inputs = $Inputs.retrieveInput()
	motion = $Movement.move(inputs, motion, speed, jumpForce, gravity, is_on_floor(), is_on_ceiling(), is_on_wall(), duckLock)
	$Animation.animate(inputs, $AnimatedSprite, is_on_floor(), is_on_wall(), duckLock)
	move_and_slide(motion, Vector2(0,-1))

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
