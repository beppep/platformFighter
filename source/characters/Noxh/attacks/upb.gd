extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 63
	fastEndFrame = 37
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":2,
			"start":5,
			"end":7,
			"kb":37,
			"kbscaling":0.1,
			"angle":99,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[33,33,0,-30]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":2,
			"start":8,
			"end":10,
			"kb":37,
			"kbscaling":0.1,
			"angle":90,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[33,33,0,-30]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":2,
			"start":11,
			"end":13,
			"kb":37,
			"kbscaling":0.1,
			"angle":90,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[33,33,0,-30]
			]
		},
		{
			"name":"3",
			"group":4,
			"damage":2,
			"start":14,
			"end":16,
			"kb":37,
			"kbscaling":0.1,
			"angle":90,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[33,33,0,-30]
			]
		},
		{
			"name":"4",
			"group":5,
			"damage":3,
			"start":17,
			"end":20,
			"kb":94,
			"kbscaling":0.4,
			"angle":80,
			"shapes":[
				[33,33,0,-30]
			]
		},
	]

func update():
	if player.stateTimer==0:
		#player.cant_hitfall = true
		player.anim_sprite.play("upb")
	if player.stateTimer<15:
		player.reverse()
	if player.stateTimer<30:
		player._velocity *= 0.9
		player._velocity.y-=150

func onHit(name, target, shielded=false):
	target.position = (target.position*0.9+player.position*0.1)
	if not shielded:
		endFast = true
	if name=="3" and not shielded:
		player.cant_hitfall = false
