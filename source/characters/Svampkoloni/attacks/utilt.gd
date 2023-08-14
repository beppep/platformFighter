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
			"damage":8,
			"start":8,
			"end":12,
			"kb":90,
			"kbscaling":0.5,
			"angle":95,
			"shapes":[
				[16,48,30,-34]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":9,
			"start":8,
			"end":11,
			"kb":100,
			"kbscaling":0.5,
			"angle":99,
			"shapes":[
				[25,30,33,-20]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("utilt")
