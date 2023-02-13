extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 54
	fastEndFrame = 41
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":15,
			"start":15,
			"end":19,
			"kb":80,
			"kbscaling":2.3,
			"angle":30,
			"shapes":[
				[30,30,32,2]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("nair")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 12
