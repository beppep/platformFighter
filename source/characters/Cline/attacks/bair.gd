extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 30
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"start":7,
			"end":11,
			"kb":50,
			"kbscaling":1,
			"angle":132,
			"shapes":[
				[30,20,-30,15]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":5,
			"start":11,
			"end":15,
			"kb":40,
			"kbscaling":0.4,
			"angle":132,
			"shapes":[
				[30,20,-30,15]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("bair")
	if player.stateTimer==13:
		if player.buttons[1] or player.c_direction.x*player.transform.x.x<0:
			player.stateTimer -= 1
			player.anim_sprite.pause()
		else:
			player.anim_sprite.play()
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 9
