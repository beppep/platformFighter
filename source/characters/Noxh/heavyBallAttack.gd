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
		},
	]


func update():
	hitboxes[0]["angle"] = rad2deg(-player._velocity.angle())

func onHit(name, target, shielded=false):
	if shielded:
		get_parent()._velocity *= -1
		
		#get_parent()._velocity.y -= 500
		#get_parent().team = -1
