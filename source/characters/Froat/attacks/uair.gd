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
			"damage":11,
			"start":7,
			"end":17,
			"kb":100,
			"kbscaling":2,
			"angle":80,
			"shapes":[
				[24,40,10,-74]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("uair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 10

