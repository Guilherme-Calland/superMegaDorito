extends KinematicBody2D

var inputs
var motion = Vector2(0,0)
export var speed = 10
export var jumpForce = 100
export var gravity = 5

func _ready():
	$Inputs.connect("ducking", self, "changeCollision")	

func _physics_process(delta):
	inputs = $Inputs.retrieveInput()
	motion = $Movement.move(inputs, motion, speed, jumpForce, gravity, is_on_floor(), is_on_ceiling(), is_on_wall())
	$Animation.animate(inputs, $AnimatedSprite, is_on_floor(), is_on_wall())
	
	move_and_slide(motion, Vector2(0,-1))

func changeCollision(ducking):
	if ducking and is_on_floor():
		$CollisionStanding.disabled = true
		$CollisionDucking.disabled = false
	else:
		$CollisionStanding.disabled = false
		$CollisionDucking.disabled = true
	
