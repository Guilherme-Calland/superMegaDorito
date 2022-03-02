extends Node2D

signal onTerrainEntered

func _ready():
	$GrassArea.connect("onTerrainEntered", self, "onTerrainEntered")
	
func onTerrainEntered(terrain, key):
	emit_signal("onTerrainEntered", terrain, key)
