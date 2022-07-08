extends Attack




func _init():
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":9,
			"kb":70,
			"kbscaling":0.5,
			"angle":60,
		},
	]


func update():
	hitboxes[0]["angle"] = rad2deg(-player._velocity.angle())

func onHit(name, target, shielded=false):
	pass
		
