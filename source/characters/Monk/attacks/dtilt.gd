extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 31
	fastEndFrame = 29
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":9,
			"start":8,
			"end":14,
			"kb":120,
			"kbscaling":1,
			"angle":85,
			"shapes":[
				[10,10,0,-60]
			]
		},
		{
			"name":"0",
			"group":1,
			"damage":15,
			"start":21,
			"end":28,
			"kb":125,
			"kbscaling":0.6,
			"angle":65,
			"shapes":[
				[35,27,75,30]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (nooooot)
		player.anim_player.play("dtilt")
	#if player.stateTimer==4:
	#	player._velocity.x+=player.transform.x.x*500
	if not player.is_on_ground:
		interrupted = true
