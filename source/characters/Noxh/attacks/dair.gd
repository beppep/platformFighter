extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 35
	fastEndFrame = 26
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":2,
			"start":5,
			"end":7,
			"kb":40,
			"kbscaling":0.1,
			"angle":-100,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[28,28,0,40]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":2,
			"start":8,
			"end":10,
			"kb":40,
			"kbscaling":0.1,
			"angle":-70,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[28,28,0,40]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":2,
			"start":11,
			"end":13,
			"kb":40,
			"kbscaling":0.1,
			"angle":-100,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[28,28,0,40]
			]
		},
		{
			"name":"3",
			"group":4,
			"damage":3,
			"start":15,
			"end":18,
			"kb":50,
			"kbscaling":1,
			"angle":-60,
			"shapes":[
				[28,28,0,40]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.cant_hitfall = true
		player.anim_sprite.play("dair")
	if player.is_on_floor():
		interrupted = true
		if not endFast:
			landingLag = 10


func onHit(name, target, shielded=false):
	get_parent()._velocity.y*=0.5
	if not shielded:
		endFast = true
	if name=="3" and not shielded:
		get_parent().cant_hitfall = false
