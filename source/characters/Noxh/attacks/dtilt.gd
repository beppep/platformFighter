extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 28
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"start":6,
			"end":11,
			"kb":70,
			"kbscaling":1.5,
			"angle":63,
			"shapes":[
				[28,22,43,22]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("dtilt")
	if player.stateTimer>4 and player.stateTimer<8:
		player._velocity.x = player.transform.x.x*800
		player._velocity.y = 40
	if not player.is_on_ground:
		pass
		interrupted = true
