extends "res://source/characters/Attack.gd"


func _init() -> void:
	endFrame = 28
	fastEndFrame = 22
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":5,
			"end":8,
			"kb":40,
			"kbscaling":0.1,
			"angle":99,
			"autolinkX":0.9,
			"autolinkY":0.5,
			"shapes":[
				[40,30,0,-33]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":4,
			"start":13,
			"end":16,
			"kb":100,
			"kbscaling":1,
			"angle":60,
			"shapes":[
				[42,32,0,-33]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("uair")
	if player.is_on_ground:
		if not endFast:
			landingLag = 10
