extends Attack



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 20
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":2,
			"start":4,
			"end":6,
			"kb":50,
			"kbscaling":0.5,
			"angle":120,
			#"autolinkX":0.5,
			#"autolinkY":0.5,
			"shapes":[
				[20,20,-40,0]
			],
		},
		{
			"name":"1",
			"group":2,
			"damage":2,
			"start":7,
			"end":9,
			"kb":50,
			"kbscaling":0.5,
			"angle":120,
			#"autolinkX":0.5,
			#"autolinkY":0.5,
			"shapes":[
				[20,20,-40,0]
			],
		},
		{
			"name":"2",
			"group":3,
			"damage":3,
			"start":10,
			"end":13,
			"kb":70,
			"kbscaling":1,
			"angle":130,
			#"autolinkX":0.5,
			#"autolinkY":0.5,
			"shapes":[
				[20,20,-40,0]
			],
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("bair2")
	if player.is_on_ground:
		interrupted = true

	if player.stateTimer<11:
		player.grab_target.position = player.position + player.transform.x.x*Vector2(-50,0)
		#player.grab_target._velocity = player._velocity
