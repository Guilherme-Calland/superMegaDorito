extends Area2D

signal cameraTrigger

func _on_body_entered(body, newPosition, lock):
	emit_signal("cameraTrigger", newPosition, lock)
	queue_free()
