extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 25
	fastEndFrame = 15
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":6,
			"start":5,
			"end":11,
			"kb":40,
			"kbscaling":1,
			"angle":66,
			"shapes":[
				[30,16,10,20]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("dtilt")
	if player.stateTimer>1 and player.stateTimer<8:
		player._velocity.x = 500*player.transform.x.x
	if not player.is_on_ground:
		pass
		if player.stateTimer>13:
			interrupted = true
