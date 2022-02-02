extends KinematicBody2D

var inputs
var motion = Vector2(0,0)
export var speed = 10
export var jumpForce = 100
export var gravity = 5

func _physics_process(delta):
	inputs = $Inputs.retrieveInput()
	motion = $Movement.move(inputs, motion, speed, jumpForce, gravity, is_on_floor())
	$Animation.animate(inputs, $AnimatedSprite, is_on_floor())
	
	move_and_slide(motion, Vector2(0,-1))
