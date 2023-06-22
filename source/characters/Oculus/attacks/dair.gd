extends Attack
#class_name Fair



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 38
	fastEndFrame = 28
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":9,
			"start":11,
			"end":14,
			"kb":60,
			"kbscaling":0.7,
			"angle":-100,
			"shapes":[
				[30,25,-4,32]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("dair")
	if player.stateTimer==12:
		player._velocity.y = -1000
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 10
