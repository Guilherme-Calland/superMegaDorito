extends Node2D

var cameraLock = false

func _ready():
	$MoveCameraTrigger1.connect("cameraTrigger", self, "onCameraTrigger1")

func _process(delta):
	$Player.run()
	if not cameraLock:
		setCameraToLowerLeftPosition(-36, 5)
		if $Player.is_on_floor():
			cameraLock = true

func onCameraTrigger1():
	setCameraToLowerLeftPosition(-5, 1)

func setCameraToLowerLeftPosition(xOffset, yOffset):
	$Camera2D.position = $Player.position + Vector2(230 + xOffset, -120 + yOffset)
	
