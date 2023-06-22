extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 50
	fastEndFrame = 40
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":8,
			"end":12,
			"kb":40,
			"kbscaling":0.2,
			"angle":70,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[25,35,-58,-8]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":3,
			"start":16,
			"end":20,
			"kb":40,
			"kbscaling":0.2,
			"angle":-110,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[26,36,-58,-8]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":4,
			"start":24,
			"end":28,
			"kb":80,
			"kbscaling":1,
			"angle":130,
			"shapes":[
				[28,38,-58,-8]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("bair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 5
