extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 34
	fastEndFrame = 24
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":9,
			"start":6,
			"end":12,
			"kb":110,
			"kbscaling":1,
			"angle":100,
			"shapes":[
				[15,30,-8,-87]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":9,
			"start":18,
			"end":21,
			"kb":55,
			"kbscaling":0.7,
			"angle":-45,
			"shapes":[
				[25,25,22,6]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("utilt")
	if not player.is_on_floor():
		interrupted = true
