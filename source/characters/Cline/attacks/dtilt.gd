extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 29
	fastEndFrame = 22
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":4,
			"end":7,
			"kb":35,
			"kbscaling":0.1,
			"angle":-80,
			"shapes":[
				[33,18,45,24]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":4,
			"start":14,
			"end":16,
			"kb":100,
			"kbscaling":0.9,
			"angle":80,
			"shapes":[
				[33,18,45,24]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("dtilt")
	if not player.is_on_ground:
		pass
		interrupted = true
