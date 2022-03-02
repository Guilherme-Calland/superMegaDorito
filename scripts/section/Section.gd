extends Node2D

func _ready():
	$NewSectionTrigger.connect("collisionEnable", self, "enableCollision")

func enableCollision():
	$MovementBlockTrigger.enableCollision()

