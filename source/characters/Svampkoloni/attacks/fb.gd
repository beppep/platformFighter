extends "res://source/characters/Attack.gd"



var spore = load("res://source/characters/Svampkoloni/spore.tscn")


func _init() -> void:
	endFrame = 52
	fastEndFrame = 42
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"start":13,
			"end":24,
			"kb":80,
			"kbscaling":0.5,
			"angle":110,
			"shapes":[
				[30,40,-50,0]
			]
		},
	]

func update():
	
	player._velocity *= 0.9
	
	if player.stateTimer==0:
		player.anim_sprite.play("fb")
		player.transform.x.x *= -1

	if 10<player.stateTimer and player.stateTimer<30:
		player._velocity = Vector2(-500*player.transform.x.x,-30)
		
	if player.stateTimer==12:
		player.createSpore(Vector2(1000*player.transform.x.x,-100))

	if player.is_on_ground and false:
		interrupted = true
		if not endFast:
			landingLag = 11
