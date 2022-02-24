extends Area2D

signal cameraTrigger

func _on_body_entered(body):
	emit_signal("cameraTrigger")
	queue_free()
