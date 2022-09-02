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
			"start":15,
			"end":24,
			"kb":70,
			"kbscaling":0.5,
			"angle":120,
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
		var svamp = spore.instance()
		svamp.position = player.position
		svamp.team = player.team
		svamp.transform.x.x = player.transform.x.x
		svamp._velocity = Vector2(1000*player.transform.x.x,-100) + player._velocity
		player.get_node("/root/Node2D/Articles").add_child(svamp)
		svamp.attackWith("sporeAttack")
		svamp.modulate = player.sprite_color
		svamp.anim_sprite.play("spore")
		svamp.myOwner = player

	if player.is_on_ground and false:
		interrupted = true
		if not endFast:
			landingLag = 11
