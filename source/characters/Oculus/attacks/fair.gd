extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 36
	fastEndFrame = 26
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":6,
			"end":13,
			"kb":40,
			"kbscaling":1,
			"angle":-40,
			"shapes":[
				[15,30,32,5]
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
