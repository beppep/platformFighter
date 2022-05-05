extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 32
	fastEndFrame = 23
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":15,
			"start":8,
			"end":14,
			"kb":125,
			"kbscaling":0.6,
			"angle":65,
			"shapes":[
				[35,27,75,30]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":9,
			"start":17,
			"end":20,
			"kb":120,
			"kbscaling":1,
			"angle":95,
			"shapes":[
				[10,20,2,-66]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_sprite.play("dtilt")
	#if player.stateTimer==4:
	#	player._velocity.x+=player.transform.x.x*500
	if not player.is_on_ground:
		interrupted = true
