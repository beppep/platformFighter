extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 34
	fastEndFrame = 26
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":5,
			"end":8,
			"kb":35,
			"kbscaling":0.1,
			"angle":-80,
			"shapes":[
				[37,18,65,24]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":4,
			"start":17,
			"end":20,
			"kb":100,
			"kbscaling":1.2,
			"angle":80,
			"shapes":[
				[40,8,65,34]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("dtilt")
	if not player.is_on_ground:
		pass
		interrupted = true
