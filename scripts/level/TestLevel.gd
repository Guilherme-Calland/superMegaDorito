extends Node2D

func _ready():
	connectCameraTriggers()

func _process(delta):
	$Player.run()

func _on_MovementLock_body_entered(body, lockDirection):
	if lockDirection == "left":
		$Player.leftLock = true
	elif lockDirection == "right":
		$Player.rightLock = true

func changeCameraPosition(newPosition, lock):
	$CameraNodes/Camera2D.changePosition(newPosition)
	if lock == 1:
		$CameraNodes/MovementLock1/CollisionShape2D.set_deferred("disabled", false)
	elif lock == 3:
		$CameraNodes/MovementLock3/CollisionShape2D.set_deferred("disabled", false)

func connectCameraTriggers():
	$CameraNodes/MoveCameraTrigger1.connect("cameraTrigger", self, "changeCameraPosition")
	$CameraNodes/MoveCameraTrigger2.connect("cameraTrigger", self, "changeCameraPosition")
	$CameraNodes/MoveCameraTrigger3.connect("cameraTrigger", self, "changeCameraPosition")
	$CameraNodes/MoveCameraTrigger4.connect("cameraTrigger", self, "changeCameraPosition")

func _on_MovementLock_body_exited(body):
	$Player.leftLock = false
	$Player.rightLock = false
