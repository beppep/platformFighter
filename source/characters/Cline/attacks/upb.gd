extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 57
	fastEndFrame = 33
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"start":6,
			"end":10,
			"kb":50,
			"kbscaling":0.1,
			"angle":88,
			"autolinkX":0.9,
			"autolinkY":0.7,
			"shapes":[
				[40,40,30,0]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":7,
			"start":10,
			"end":14,
			"kb":35,
			"kbscaling":0.1,
			"angle":88,
			"autolinkX":0.9,
			"autolinkY":0.7,
			"shapes":[
				[40,40,30,0]
			]
		},
		{
			"name":"2",
			"group":1,
			"damage":7,
			"start":15,
			"end":17,
			"kb":20,
			"kbscaling":0.1,
			"angle":88,
			"autolinkX":0.9,
			"autolinkY":0.5,
			"shapes":[
				[48,48,30,0]
			]
		},
		{
			"name":"3",
			"group":2,
			"damage":9,
			"start":20,
			"end":27,
			"kb":70,
			"kbscaling":1.1,
			"angle":-87, 
			"shapes":[
				[48,28,30,0]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.cant_hitfall = true
		player._velocity.y = 0
		player.anim_sprite.play("upb")
	if player.stateTimer<5:
		player.reverse()
		player._velocity.x *= 0.9
	if 5<player.stateTimer and player.stateTimer<15:
		if player._velocity.x*player.transform.x.x<0:
			player._velocity.x = 0
		player._velocity.x *= 0.9
		player._velocity.y = -1600
	
	if 20<player.stateTimer and player.stateTimer<25:
		player._velocity.x *= 0.9
		player._velocity.y = 1000
	
	
	if player.is_on_ground and player.stateTimer>21:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 20
