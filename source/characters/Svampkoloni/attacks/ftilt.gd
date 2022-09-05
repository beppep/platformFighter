extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 29
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"start":18,
			"end":22,
			"kb":120,
			"kbscaling":0.1,
			"angle":80,
			"shapes":[
				[50,18,65,10]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":9,
			"start":24,
			"end":30,
			"kb":90,
			"kbscaling":1.2,
			"angle":105,
			"shapes":[
				[18,30,118,-20]
			]
		},
		{
			"name":"2",
			"group":2,
			"damage":12,
			"start":24,
			"end":30,
			"kb":60,
			"kbscaling":1.2,
			"angle":-105,
			"shapes":[
				[18,30,118,32]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("ftilt")

func onHit(name, target, shielded=false):
	pass
