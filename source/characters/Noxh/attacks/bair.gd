extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 30
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":6,
			"start":5,
			"end":13,
			"kb":100,
			"kbscaling":0.2,
			"angle":101,
			"shapes":[
				[30,40,-44,5]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("bair")

	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 9
