extends Attack




func _init():
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":9,
			"kb":70,
			"kbscaling":1,
			"angle":60,
			"autolinkY":0.1,
		},
	]


func update():
	#hitboxes[0]["angle"] = rad2deg(-player._velocity.angle())
	#if player._velocity.x>0:
	#	hitboxes[0]["angle"] = 60
	#else:
	#	hitboxes[0]["angle"] = 120
	pass

func onHit(name, target, shielded=false):
	player._velocity *= -1
		
