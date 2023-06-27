extends "res://source/characters/Attack.gd"



func _init() -> void:
	endFrame = 70
	fastEndFrame = 45
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":5,
			"start":6,
			"end":12,
			"kb":80,
			"kbscaling":0.1,
			"angle":50,
			"shapes":[
				[30,30,20,-10]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":5,
			"start":13,
			"end":22,
			"kb":70,
			"kbscaling":0.1,
			"angle":30,
			"shapes":[
				[30,30,20,0]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":5,
			"start":23,
			"end":30,
			"kb":70,
			"kbscaling":0.1,
			"angle":0,
			"shapes":[
				[30,30,20,10]
			]
		},
		{
			"name":"3",
			"group":4,
			"damage":5,
			"start":31,
			"end":38,
			"kb":100,
			"kbscaling":0.5,
			"angle":-30,
			"shapes":[
				[30,30,20,10]
			]
		},
	]


func update():
	if player.stateTimer==0:
		player.anim_sprite.play("upb")
	if player.stateTimer<5:
		player.reverse()
		player._velocity = Vector2.ZERO
	elif player.stateTimer>=5 and player.stateTimer<=10:
		player._velocity.x = player.transform.x.x*500
		if player.stateTimer == 5:
			player._velocity.y = -1000
	if player.is_on_ground and player.stateTimer>20:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 25

