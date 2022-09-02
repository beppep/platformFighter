extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var grabbedWall = false

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 31
	fastEndFrame = 22
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":9,
			"start":8,
			"end":12,
			"kb":90,
			"kbscaling":0.9,
			"angle":99,
			"shapes":[
				[20,52,30,-55]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":9,
			"start":8,
			"end":11,
			"kb":100,
			"kbscaling":1,
			"angle":99,
			"shapes":[
				[25,32,46,-26]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("utilt")
