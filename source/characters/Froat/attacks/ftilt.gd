extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 29
	fastEndFrame = 17
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":6,
			"end":9,
			"kb":150,
			"kbscaling":1,
			"angle":72,
			"shapes":[
				[28,33,43,-6]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (nooooot)
		player.anim_player.play("ftilt")
	if not player.is_on_ground:
		interrupted = true