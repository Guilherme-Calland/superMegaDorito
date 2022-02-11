extends AudioStreamPlayer

var unlocked = false

func emitAudio(sprite):
	if sprite.animation == "run":
		var frame = sprite.get_frame()		
		if unlocked:
			if not playing:
				stream = load("res://audio/0.ogg")
				if frame%2 == 0:
					play()
		
		if frame == 2:
			unlocked = true
	else:
		unlocked = false
