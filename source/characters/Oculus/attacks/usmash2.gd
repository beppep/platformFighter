extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 30
	fastEndFrame = 30
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":6,
			"end":9,
			"kb":50,
			"kbscaling":0.5,
			"angle":90,
			#"autolinkX":0.5,
			#"autolinkY":0.5,
			"shapes":[
				[20,20,0,-30]
			],
		},
		{
			"name":"1",
			"group":2,
			"damage":3,
			"start":12,
			"end":15,
			"kb":50,
			"kbscaling":0.5,
			"angle":90,
			#"autolinkX":0.5,
			#"autolinkY":0.5,
			"shapes":[
				[20,20,0,-30]
			],
		},
		{
			"name":"2",
			"group":3,
			"damage":5,
			"start":18,
			"end":22,
			"kb":90,
			"kbscaling":1.5,
			"angle":90,
			#"autolinkX":0.5,
			#"autolinkY":0.5,
			"shapes":[
				[20,20,0,-30]
			],
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("usmash2")

	if player.stateTimer<20:
		player._velocity *= 0.9
		player._velocity.y -= 80
		player.grab_target.position = player.position + Vector2(0,-50)
		#player.grab_target._velocity = player._velocity
