extends Attack




func _init():
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":9,
			"start":1,
			"end":80,
			"kb":70,
			"kbscaling":0.7,
			"angle":60,
			"shapes":[
				[44,24,0,0]
			]
		},
	]


func update():
	var targetPos = player.ownerObject.position# + Vector2(0,50)
	player._velocity = (targetPos-player.position).normalized()*2000
	if player.transform.x.x>0:
		hitboxes[0]["angle"] = -rad_to_deg(player._velocity.angle())
	else:
		hitboxes[0]["angle"] = 180+rad_to_deg(player._velocity.angle())
	
	player.set_collision_mask_value(1,0)
	
	if targetPos.distance_to(player.position)<30:
		interrupted = true
		endAttack()
		player.attachTo(player.ownerObject)

		
