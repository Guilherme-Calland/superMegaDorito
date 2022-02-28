extends Area2D

func _on_CloudDestroyer_area_entered(area):
	print('hello world')
	area.destroy()
