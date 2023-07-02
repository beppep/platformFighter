extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 35
	fastEndFrame = 25
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":4,
			"end":7,
			"kb":20,
			"kbscaling":0.1,
			"angle":40,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[35,18,55,-10]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":6,
			"start":12,
			"end":15,
			"kb":100,
			"kbscaling":1,
			"angle":45,
			"shapes":[
				[35,18,55,-10]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.cant_hitfall = true
		player.anim_sprite.play("ftilt")
	if player.stateTimer==8:
		player.cant_hitfall = false
