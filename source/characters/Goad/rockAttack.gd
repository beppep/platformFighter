extends Attack




func _init():
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"kb":60,
			"kbscaling":0.8,
			"angle":60,
			"autolinkX":-9,
			"autolinkY":-9,
		},
	]


func update():
	#hitboxes[0]["angle"] = rad2deg(-player._velocity.angle())
	if player._velocity.x==0:
		hitboxes[0]["angle"] = 90
		print("unmoving rock!")
	else:
		if player._velocity.x*player.transform.x.x>0:
			hitboxes[0]["angle"] = 60
		else:
			hitboxes[0]["angle"] = 120
	pass

func onHit(name, target, shielded=false):
	player._velocity *= -1
		
