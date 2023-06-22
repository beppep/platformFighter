extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 36
	fastEndFrame = 26
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":5,
			"end":7,
			"kb":25,
			"kbscaling":0.1,
			"angle":88,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[25,50,55,5]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":5,
			"start":14,
			"end":16,
			"kb":40,
			"kbscaling":1.4,
			"angle":60,
			"shapes":[
				[25,50,55,5]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("fair")

	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 12
