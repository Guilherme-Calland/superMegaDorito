extends Node

func retrieveInput():
	var inputs = {
		"right" : false,
		"left" : false,
		"jump" : false
	}
	
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		inputs["right"] = true
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		inputs["left"] = true
	
	if Input.is_action_just_pressed("jump"):
		inputs["jump"] = true
		
	return inputs
