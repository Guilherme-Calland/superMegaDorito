extends Node

signal ducking

func retrieveInput():
	var inputs = {
		"up" : false,
		"down" : false,
		"right" : false,
		"left" : false,
		"jump" : false,
		"duck" : false,
		"grab" : false,
		"dash" : false
	}
	
	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		inputs["right"] = true
		if Input.is_action_just_pressed("right"):
			inputs["runStart"] = true
	elif Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		inputs["left"] = true
		if Input.is_action_just_pressed("right"):
			inputs["runStart"] = true
	if Input.is_action_pressed("up") and not Input.is_action_pressed("down"):
		inputs["up"] = true
	elif Input.is_action_pressed("down") and not Input.is_action_pressed("up"):
		inputs["down"] = true
	
	if Input.is_action_just_pressed("jump"):
		inputs["jump"] = true
	elif Input.is_action_pressed("duck"):
		if Input.is_action_just_pressed("duck"):
			emit_signal("ducking", true)
		inputs["duck"] = true
	elif Input.is_action_just_released("duck"):
		emit_signal("ducking", false)
	
	if Input.is_action_pressed("grab"):
		inputs["grab"] = true
	
	if Input.is_action_just_pressed("dash"):
		inputs["dash"] = true
		
	
	
	return inputs
