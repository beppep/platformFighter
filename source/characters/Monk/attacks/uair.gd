extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 28
	fastEndFrame = 18
	hitboxes = [
		
		{
			"name":"0",
			"group":1,
			"damage":2,
			"start":5,
			"end":6,
			"kb":70,
			"kbscaling":0.1,
			"angle":90,
			"autolinkX":0.5,
			"autolinkY":0.5,
			"shapes":[
				[50,40,7,-64]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":2,
			"start":8,
			"end":9,
			"kb":70,
			"kbscaling":0.1,
			"angle":90,
			"autolinkX":0.5,
			"autolinkY":0.5,
			"shapes":[
				[50,40,7,-64]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":5,
			"start":11,
			"end":13,
			"kb":50,
			"kbscaling":1.4,
			"angle":88,
			"shapes":[
				[52,42,7,-64]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("uair")
	if player.stateTimer>3 and player.stateTimer<13:
		player._velocity.y -= 80
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 10
