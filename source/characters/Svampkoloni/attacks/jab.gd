extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 18
	fastEndFrame = 12
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":3,
			"end":6,
			"kb":60,
			"kbscaling":0.3,
			"angle":66,
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
	#if not player.is_on_ground:
	#	interrupted = true
