extends Area2D

signal onTerrainEntered

func _on_GrassArea_body_entered(body):
	emit_signal("onTerrainEntered", "grass", "")
