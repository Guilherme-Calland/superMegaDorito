extends Node2D

var cloud_sprite_1 = "res://graphics/background/clouds/nighttime/cloud_1_blue.png"
var cloud_sprite_2 = "res://graphics/background/clouds/nighttime/cloud_2_blue.png"
var cloud_sprite_3 = "res://graphics/background/clouds/nighttime/cloud_3_blue.png"

var generator = RandomNumberGenerator.new()
var speed = 0.0

func _ready():
	generator.seed = 1
	generator.randomize()
	var randNum = generator.randi_range(0, 2)
	if randNum == 0:
		$Sprite.texture = load(cloud_sprite_1)
	elif randNum == 1:
		$Sprite.texture = load(cloud_sprite_2)
	elif randNum == 2:
		$Sprite.texture = load(cloud_sprite_3)
	
	generator.randomize()
	speed = generator.randf_range(0.05,0.15)
	
func _process(delta):
	position.x -= speed

func destroy():
	queue_free()
