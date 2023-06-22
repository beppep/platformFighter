extends "res://source/characters/Attack.gd"


func _init() -> void:
	endFrame = 40
	fastEndFrame = 25
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":9,
			"start":8,
			"end":13,
			"kb":60,
			"kbscaling":0.5,
			"angle":-33,
			"shapes":[
				[38,33,38,33]
			],
			"extrahitpause":8,
			"electric":8,
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("db2")
	if player.stateTimer<5:
		player.reverse()
	if player.stateTimer>5:
		player.double_jumps = 1
		player._velocity *= 0.7

