extends Attack
class_name Bair




func _init():
	endFrame = 36
	fastEndFrame = 26
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":14,
			"start":7,
			"end":10,
			"kb":150,
			"kbscaling":3,
			"angle":140,
			"shapes":[
				[7,17,-68,-10]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":9,
			"start":7,
			"end":17,
			"kb":100,
			"kbscaling":1.5,
			"angle":130,
			"shapes":[
				[27,15,-48,-10]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("bair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 5
