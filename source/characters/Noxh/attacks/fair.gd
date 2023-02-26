extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 33
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":5,
			"end":8,
			"kb":60,
			"kbscaling":1.8,
			"angle":52,
			"shapes":[
				[50,20,55,5]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("fair")

	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 11
