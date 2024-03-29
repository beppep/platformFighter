extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 38
	fastEndFrame = 26
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":2,
			"start":6,
			"end":7,
			"kb":70,
			"kbscaling":0.1,
			"angle":80,
			"autolinkX":0.5,
			"autolinkY":0.5,
			"shapes":[
				[24,40,10,-67]
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
			"angle":80,
			"autolinkX":0.5,
			"autolinkY":0.5,
			"shapes":[
				[24,40,10,-69]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":2,
			"start":10,
			"end":11,
			"kb":70,
			"kbscaling":0.1,
			"angle":80,
			"autolinkX":0.5,
			"autolinkY":0.5,
			"shapes":[
				[24,40,10,-71]
			]
		},
		{
			"name":"3",
			"group":4,
			"damage":6,
			"start":12,
			"end":16,
			"kb":60,
			"kbscaling":1.3,
			"angle":80,
			"shapes":[
				[24,40,10,-73]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("uair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 10

func onHit(name, target, shielded=false):
	if name!="3" and not player.direction.y>0.5:
		target.position = (target.position*0.9+player.position*0.1)
	if not shielded:
		endFast = true
