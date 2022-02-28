extends Node

func emitAudio(sprite, flags, jumpAudioEnabled, dashAudioEnabled, terrainAudioEnabled):
	if terrainAudioEnabled:
		$AmbientAudio.emitAudio(sprite, flags)
	$PlayerAudio.emitAudio(flags, jumpAudioEnabled, dashAudioEnabled)
