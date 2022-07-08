extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 33
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":6,
			"start":5,
			"end":8,
			"kb":50,
			"kbscaling":1.2,
			"angle":55,
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
