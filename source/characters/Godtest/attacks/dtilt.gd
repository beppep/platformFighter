extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 28
	fastEndFrame = 21
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":5,
			"end":10,
			"kb":70,
			"kbscaling":0.5,
			"angle":50,
			"shapes":[
				[32,18,50,18]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("dtilt")
