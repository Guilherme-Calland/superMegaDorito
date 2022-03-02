extends Node2D

func _ready():
	connectInitialSignals()

func _process(delta):
	$Player.run()

func connectInitialSignals():
	$Sections/Section1/Section/AudioTriggers.connect("onTerrainEntered", self, "onTerrainEntered")
	$Sections/Section1/Section/NewSectionTrigger.connect("cameraMove", self, "moveCamera")
	$Sections/Section1/Section/NewSectionTrigger.connect("sectionCreate", self, "createSection")
	$Sections/Section1/Section/MovementBlockTrigger.connect("playerMovementBlock", self, "blockPlayerMovement")
	$Sections/Section1/Section/MovementBlockTrigger.connect("playerMovementFree", self, "freePlayerMovement")

func onTerrainEntered(terrain, key):
	$Player.onTerrainEntered(terrain, key)
	
func moveCamera(position):
	$Camera.move(position)

func blockPlayerMovement(direction):
	$Player.blockMovement(direction)

func freePlayerMovement():
	$Player.freeMovement()

func createSection(newSection, sectionNum):
	$Sections.createSection(newSection, sectionNum)
	connectNewSignals(newSection)

func connectNewSignals(newSection):
	newSection.get_node("NewSectionTrigger").connect("cameraMove", self, "moveCamera")
	newSection.get_node("NewSectionTrigger").connect("sectionCreate", self, "createSection")
	newSection.get_node("NewSectionTrigger").connect("sectionDestroy", self, "destroySection")
	newSection.get_node("AudioTriggers").connect("onTerrainEntered", self, "onTerrainEntered")
	newSection.get_node("MovementBlockTrigger").connect("playerMovementBlock", self, "blockPlayerMovement")
	newSection.get_node("MovementBlockTrigger").connect("playerMovementFree", self, "freePlayerMovement")

func destroySection(sectionNum):
	$Sections.destroySection(sectionNum)


