extends Node2D

func _ready():
	$LevelStageTriggers.connect("cameraMove", self, "moveCamera")
	$LevelStageTriggers.connect("cloudGeneratorMove",self,"moveCloudGenerator")
	$LevelStageTriggers.connect("areaDestroy", self, "destroyArea")
	$LevelStageTriggers.connect("areaInstanciate", self, "instanciateArea")
	

func _process(delta):
	$Player.run()
	
func moveCamera(position):
	$Camera2D.move(position)
	
func moveCloudGenerator(position):
	$Background/CloudGenerator.move(position)

func destroyArea(area):
	$Terrain.destroyArea(area)

func instanciateArea(area):
	$Terrain.instanciateArea(area)

