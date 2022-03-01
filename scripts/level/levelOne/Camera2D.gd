extends Camera2D

func _ready():
	global_position = Vector2(240,-115)

func move(position):
	global_position = position
