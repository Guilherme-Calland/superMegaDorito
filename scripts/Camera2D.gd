extends Camera2D

func _ready():
	global_position = Vector2(108, -123)

func changePosition(newPosition):
	global_position = newPosition
