extends "res://source/characters/Attack.gd"


func _init() -> void:
	endFrame = 29
	fastEndFrame = 18
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":6,
			"end":9,
			"kb":50,
			"kbscaling":0.8,
			"angle":55,
			"shapes":[
				[33,33,17,17]
			]
		},
	]

func update():
	player.z_index = 2
	if player.stateTimer==0:
		player.anim_sprite.play("nair")
	if player.stateTimer==2:
		player._velocity.y *= 0.5
		player._velocity.y -= 400
		player._velocity.x += 400*player.transform.x.x
	if player.stateTimer==7:
		player._velocity.x *= 0.5
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 9
