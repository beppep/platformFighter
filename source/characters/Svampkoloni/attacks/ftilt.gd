extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 39
	fastEndFrame = 29
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":6,
			"start":9,
			"end":13,
			"kb":60,
			"kbscaling":0.1,
			"angle":30,
			"shapes":[
				[30,18,70,10]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":8,
			"start":15,
			"end":19,
			"kb":60,
			"kbscaling":1.2,
			"angle":105,
			"shapes":[
				[18,18,102,-20]
			]
		},
		{
			"name":"2",
			"group":2,
			"damage":10,
			"start":15,
			"end":19,
			"kb":60,
			"kbscaling":1.2,
			"angle":-105,
			"shapes":[
				[18,18,102,32]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("ftilt")
