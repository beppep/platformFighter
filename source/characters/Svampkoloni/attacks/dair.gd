extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 35
	fastEndFrame = 26
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":7,
			"end":9,
			"kb":70,
			"kbscaling":0.1,
			"angle":170,
			"autolinkX":1,
			#"autolinkY":1,
			"shapes":[
				[20,20,50,50]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":4,
			"start":7,
			"end":9,
			"kb":80,
			"kbscaling":0.1,
			"angle":20,
			"autolinkX":1,
			#"autolinkY":1,
			"shapes":[
				[20,20,-40,60]
			]
		},
		{
			"name":"2",
			"group":2,
			"damage":6,
			"start":19,
			"end":20,
			"kb":60,
			"kbscaling":1,
			"angle":-30,
			"shapes":[
				[12,20,55,50]
			]
		},
		{
			"name":"3",
			"group":2,
			"damage":6,
			"start":19,
			"end":20,
			"kb":60,
			"kbscaling":1,
			"angle":-150,
			"shapes":[
				[12,20,-45,60]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.cant_hitfall = true
		player.anim_sprite.play("dair")
	if player.is_on_floor():
		interrupted = true
		if not endFast:
			landingLag = 9



func onHit(name, target, shielded=false):
	player._velocity.y=-500
	if (name=="2" or name=="3") and not shielded:
		player.cant_hitfall = false
	endFast = true
