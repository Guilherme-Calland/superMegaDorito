extends Node

signal cameraMove
signal cloudGeneratorMove
signal areaDestroy
signal areaInstanciate

func _on_Trigger_body_entered(body, cameraPosition, cloudPosition, instanciateArea, destroyArea, enableCollision):
	emit_signal("cameraMove", cameraPosition)
	emit_signal("cloudGeneratorMove", cloudPosition)
	if enableCollision:
		$AreaBarrier/CollisionShape2D.set_deferred("disabled", false)
	
	if destroyArea != -1:
		emit_signal("areaDestroy", destroyArea)
	
	if instanciateArea != -1:
		emit_signal("areaInstanciate", instanciateArea)
	

	
