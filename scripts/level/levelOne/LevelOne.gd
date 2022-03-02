extends Node2D

var section2 = preload("res://scenes/level/levelOne/Section2.tscn").instance()

func _ready():
	$Sections/Section1/Section/AudioTriggers.connect("onTerrainEntered", self, "onTerrainEntered")
	$Sections/Section1/Section/NewSectionTrigger.connect("cameraMove", self, "moveCamera")
	$Sections/Section1/Section/NewSectionTrigger.connect("sectionCreate", self, "createSection")
	$Sections/Section1/Section/MovementBlockTrigger.connect("playerMovementBlock", self, "blockPlayerMovement")
	$Sections/Section1/Section/MovementBlockTrigger.connect("playerMovementFree", self, "freePlayerMovement")


func _process(delta):
	$Player.run()
	
func onTerrainEntered(terrain, key):
	$Player.onTerrainEntered(terrain, key)
	
func moveCamera(position):
	$Camera.move(position)

func blockPlayerMovement(direction):
	$Player.blockMovement(direction)

func freePlayerMovement():
	$Player.freeMovement()

func createSection(section):
	$Sections.createSection(section)
