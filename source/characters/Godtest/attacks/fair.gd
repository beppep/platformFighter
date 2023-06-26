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
			"damage":3,
			"start":4,
			"end":7,
			"kb":20,
			"kbscaling":0.1,
			"angle":-50,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[24,18,66,-20]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":6,
			"start":16,
			"end":19,
			"kb":100,
			"kbscaling":1,
			"angle":40,
			"shapes":[
				[24,18,66,0]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.cant_hitfall = true
		player.anim_sprite.play("fair")
	if player.stateTimer==8:
		player.cant_hitfall = false
		
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 10
