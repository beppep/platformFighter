extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 48
	fastEndFrame = 38
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":15,
			"start":15,
			"end":19,
			"kb":70,
			"kbscaling":1.7,
			"angle":30,
			"shapes":[
				[40,20,40,20]
			],
			"electric":8,
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("nair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 12
