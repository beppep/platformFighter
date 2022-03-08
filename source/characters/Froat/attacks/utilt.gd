extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 23
	fastEndFrame = 17
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"start":8,
			"end":14,
			"kb":200,
			"kbscaling":1,
			"angle":85,
			"shapes":[
				[44,32,3,-43]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (nooooot)
		player.anim_player.play("utilt")
	if not player.is_on_floor():
		interrupted = true
