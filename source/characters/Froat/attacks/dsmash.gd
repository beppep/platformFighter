extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 45
	fastEndFrame = 26
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":11,
			"start":10,
			"end":14,
			"kb":150,
			"kbscaling":3,
			"angle":71,
			"shapes":[
				[36,24,43,20]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":11,
			"start":22,
			"end":26,
			"kb":150,
			"kbscaling":3,
			"angle":109,
			"shapes":[
				[36,24,-43,20]
			]
		},
	]

func update(player):
	print(endFast, player.stateTimer)
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (nooooot)
		player.anim_player.play("dsmash")
	if not player.is_on_ground:
		interrupted = true

func onHit(name, target, shielded=false):
	if not shielded:
		endFast = true
