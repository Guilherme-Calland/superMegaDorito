extends Node2D

onready var camera = $Camera/Camera2D
onready var cloudGenerator = $Background/CloudGenerator

func _ready():
	print(cloudGenerator.global_position)
	camera.connect("cloudGeneratorMove", self, "moveCloudGenerator")
	camera.connect("enableBarrier",self,"enableBarrier")
	
func moveCloudGenerator(xOffset):
	print(cloudGenerator.global_position)
	var pos = cloudGenerator.global_position
	cloudGenerator.global_position.x = pos.x + xOffset

func enableBarrier():
	$ScenaryBarriers/ScenaryBarrier1/CollisionShape2D.set_deferred("disabled", false)
