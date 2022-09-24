extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 67
	fastEndFrame = 37
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":2,
			"start":8,
			"end":10,
			"kb":40,
			"kbscaling":0.1,
			"angle":99,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[33,37,0,-27]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":2,
			"start":11,
			"end":13,
			"kb":40,
			"kbscaling":0.1,
			"angle":90,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[33,37,0,-27]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":2,
			"start":14,
			"end":16,
			"kb":40,
			"kbscaling":0.1,
			"angle":90,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[33,37,0,-27]
			]
		},
		{
			"name":"3",
			"group":4,
			"damage":2,
			"start":17,
			"end":19,
			"kb":37,
			"kbscaling":0.1,
			"angle":90,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[33,37,0,-27]
			]
		},
		{
			"name":"4",
			"group":5,
			"damage":3,
			"start":20,
			"end":23,
			"kb":83,
			"kbscaling":0.2, #0.1 is nice
			"angle":77, # 80 is op
			"shapes":[
				[33,37,0,-27]
			]
		},
	]

func update():
	if player.stateTimer==13:
		player.cant_hitfall = true
	if player.stateTimer==0:
		player._velocity.y=0
		#player.cant_hitfall = true
		player.anim_sprite.play("upb")
	if player.stateTimer<15:
		player.reverse()
	if player.stateTimer<30:
		player._velocity *= 0.9
		player._velocity.y-=150
	
	
	if player.is_on_ground and player.stateTimer>31:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 20

func onHit(name, target, shielded=false):
	target.position = (target.position*0.9+player.position*0.1)
	if not shielded:
		endFast = true
	if name=="3" and not shielded:
		player.cant_hitfall = false
