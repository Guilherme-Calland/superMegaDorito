extends Node2D

func _ready():
	$MoveCameraTrigger1.connect("cameraTrigger", self, "changeCameraPosition")

func _process(delta):
	$Player.run()

func _on_MovementLock1_body_entered(body):
	$Player.leftLock = true

func _on_MovementLock1_body_exited(body):
	$Player.leftLock = false
	
func enableMovementLock():
	$MovementLock1/CollisionShape2D.set_deferred("disabled", false)

func changeCameraPosition(newPosition):
	$Camera2D.changePosition(newPosition)
