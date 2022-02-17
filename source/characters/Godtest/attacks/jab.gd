extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 16
	fastEndFrame = 11
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":5,
			"start":4,
			"end":7,
			"kb":60,
			"kbscaling":0.3,
			"angle":70,
			"shapes":[
				[24,24,28,20]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("jab")
	if not player.is_on_ground:
		interrupted = true
