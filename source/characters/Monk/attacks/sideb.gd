extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 48
	fastEndFrame = 33
	hitboxes = [
		
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":10,
			"end":13,
			"kb":40,
			"kbscaling":0.1,
			"angle":80,
			"autolinkX":0.8,
			"autolinkY":0.8,
			"shapes":[
				[40,50,70,-4]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":3,
			"start":14,
			"end":17,
			"kb":40,
			"kbscaling":0.1,
			"angle":80,
			"autolinkX":0.8,
			"autolinkY":0.8,
			"shapes":[
				[40,50,70,-4]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":5,
			"start":18,
			"end":21,
			"kb":40,
			"kbscaling":0.7,
			"angle":60,
			"shapes":[
				[42,52,70,-4]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("fb")
	if player.stateTimer>8 and player.stateTimer<20:
		player._velocity.y *= 0.9
		player._velocity.y -= 30
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 10

func onHit(name, target, shielded=false):
	if name=="2":
		player._velocity.y=-900
		player._velocity.x=700*player.transform.x.x
	else:
		player._velocity.y=-500

	if not shielded:
		endFast = true
