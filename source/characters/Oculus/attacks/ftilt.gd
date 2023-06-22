extends "res://source/characters/Attack.gd"




# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 40
	fastEndFrame = 30
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":7,
			"end":11,
			"kb":60,
			"kbscaling":1.1,
			"angle":40,
			"shapes":[
				[22,22,22,0]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":10,
			"start":7,
			"end":11,
			"kb":60,
			"kbscaling":1.2,
			"angle":40,
			"shapes":[
				[22,22,55,0]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("ftilt")
	if not player.is_on_ground:
		pass
		#interrupted = true
