extends Node2D

signal cloudGeneratorMove
signal enableBarrier

func _ready():
	$Camera2D.global_position = Vector2(240,-118)

func _on_CameraTrigger_body_entered(body, newPosition):
	$Camera2D.global_position = newPosition
	emit_signal("cloudGeneratorMove", 420)
	emit_signal("enableBarrier")
	$CameraTrigger1.queue_free()
