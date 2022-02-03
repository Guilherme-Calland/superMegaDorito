extends Area2D

func _on_SharpStone_body_entered(body):
	body.die()
