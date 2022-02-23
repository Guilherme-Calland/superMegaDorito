extends AudioStreamPlayer

func emitAudio(onDash):
	if onDash:
		if not playing:
			play()
