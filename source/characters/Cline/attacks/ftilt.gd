extends "res://source/characters/Attack.gd"




# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 38
	fastEndFrame = 28
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":9,
			"start":11,
			"end":15,
			"kb":84,
			"kbscaling":1.4,
			"angle":70,
			"shapes":[
				[33,33,55,5]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("ftilt")
	if not player.is_on_ground:
		pass
		#interrupted = true
	if 8<player.stateTimer and player.stateTimer<14:
		player._velocity.x=1000*player.transform.x.x
