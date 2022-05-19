extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 60
	fastEndFrame = 45
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":11,
			"start":10,
			"end":14,
			"kb":110,
			"kbscaling":1,
			"angle":20,
			"shapes":[
				[44,31,66,12]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":11,
			"start":26,
			"end":29,
			"kb":110,
			"kbscaling":1,
			"angle":160,
			"shapes":[
				[44,31,-66,12]
			]
		},
	]

func update(player):
	print(endFast, player.stateTimer)
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_sprite.play("dsmash")
	if not player.is_on_ground:
		interrupted = true

func onHit(name, target, shielded=false):
	if not shielded:
		endFast = true
