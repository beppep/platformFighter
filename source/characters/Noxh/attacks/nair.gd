extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 34
	fastEndFrame = 21
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":5,
			"start":5,
			"end":9,
			"kb":80,
			"kbscaling":0.3,
			"angle":86,
			"shapes":[
				[30,30,20,-20]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("nair")
	if player.stateTimer==5:
		player._velocity.y *= 0.6
		player._velocity.y -= 600
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 9
