extends Area2D

signal playerMovementBlock
signal playerMovementFree

func _on_MovementBlockTrigger_body_entered(body):
	emit_signal("playerMovementBlock", "left")

func enableCollision():
	$CollisionShape2D.set_deferred("disabled", false)

func _on_MovementBlockTrigger_body_exited(body):
	emit_signal("playerMovementFree")
