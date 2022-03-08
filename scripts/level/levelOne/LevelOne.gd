extends Node2D

var oldSection

func _ready():
	initNewSection()

func _process(delta):
	$Player.run()

func initNewSection():
	var newSection = load("res://scenes/level/levelOne/Section1.tscn").instance()
	createSection(newSection)

func onTerrainEntered(terrain, key):
	$Player.onTerrainEntered(terrain, key)
	
func moveCamera(position):
	$Camera.move(position)

func blockPlayerMovement(direction):
	$Player.blockMovement(direction)

func freePlayerMovement():
	$Player.freeMovement()

func createSection(newSection):
	$Sections.createSection(newSection)
	handleSignals(newSection)

func handleSignals(newSection):
#	if oldSection != null:
#		disconnectOldSignals()
#	oldSection = newSection
	connectNewSignals(newSection)

func destroySection(sectionNum):
	$Sections.destroySection(sectionNum)

func disconnectOldSignals():
	oldSection.get_node("NewSectionTrigger").disconnect("cameraMove", self, "moveCamera")
	oldSection.get_node("NewSectionTrigger").disconnect("sectionCreate", self, "createSection")
	oldSection.get_node("NewSectionTrigger").disconnect("sectionDestroy", self, "destroySection")
	oldSection.get_node("AudioTriggers").disconnect("onTerrainEntered", self, "onTerrainEntered")
	oldSection.get_node("MovementBlockTrigger").disconnect("playerMovementBlock", self, "blockPlayerMovement")
	oldSection.get_node("MovementBlockTrigger").disconnect("playerMovementFree", self, "freePlayerMovement")
	
func connectNewSignals(newSection):
	newSection.get_node("NewSectionTrigger").connect("cameraMove", self, "moveCamera")
	newSection.get_node("NewSectionTrigger").connect("sectionCreate", self, "createSection")
	newSection.get_node("NewSectionTrigger").connect("sectionDestroy", self, "destroySection")
	newSection.get_node("AudioTriggers").connect("onTerrainEntered", self, "onTerrainEntered")
	newSection.get_node("MovementBlockTrigger").connect("playerMovementBlock", self, "blockPlayerMovement")
	newSection.get_node("MovementBlockTrigger").connect("playerMovementFree", self, "freePlayerMovement")

