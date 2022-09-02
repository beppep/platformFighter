extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var grabbedWall = false

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 32
	fastEndFrame = 24
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":1,
			"start":6,
			"end":8,
			"kb":20,
			"kbscaling":0.1,
			"angle":90,
			"shapes":[
				[38,38,0,-32]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":1,
			"start":9,
			"end":11,
			"kb":20,
			"kbscaling":0.1,
			"angle":90,
			"shapes":[
				[40,40,0,-32]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":4,
			"start":12,
			"end":15,
			"kb":100,
			"kbscaling":1,
			"angle":90,
			"shapes":[
				[42,42,0,-32]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("utilt")
