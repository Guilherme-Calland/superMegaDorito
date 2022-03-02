extends Node

signal cameraMove
signal cloudGeneratorMove
signal areaDestroy
signal areaInstanciate

func _ready():
	$Trigger1.connect("cameraMove", self, "moveCamera")
	$Trigger1.connect("cloudGeneratorMove", self, "moveCloudGenerator")
	$Trigger1.connect("areaDestroy", self, "destroyArea")
	$Trigger1.connect("areaInstanciate", self, "instanciateArea")
	$Trigger2.connect("cameraMove", self, "moveCamera")
	$Trigger2.connect("cloudGeneratorMove", self, "moveCloudGenerator")
	$Trigger2.connect("areaDestroy", self, "destroyArea")
	$Trigger2.connect("areaInstanciate", self, "instanciateArea")
	
	
func moveCamera(position):
	emit_signal("cameraMove", position)
	
func moveCloudGenerator(position):
	emit_signal("cloudGeneratorMove", position)

func destroyArea(area):
	emit_signal("areaDestroy", area)

func instanciateArea(area):
	emit_signal("areaInstanciate", area)
