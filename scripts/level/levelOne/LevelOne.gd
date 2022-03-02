extends Node2D

var section2 = preload("res://scenes/level/levelOne/Section2.tscn").instance()

func _ready():
	$Sections/Section1/AudioTriggers.connect("onTerrainEntered", self, "onTerrainEntered")
	$Sections/Section1/NewSectionTrigger.connect("moveCamera", self, "moveCamera")
	$Sections/Section1/MovementBlockTrigger.connect("playerMovementBlock", self, "blockPlayerMovement")
	$Sections/Section1/MovementBlockTrigger.connect("playerMovementFree", self, "freePlayerMovement")

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
