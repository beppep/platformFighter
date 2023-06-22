extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 16
	fastEndFrame = 11
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":5,
			"start":4,
			"end":7,
			"kb":60,
			"kbscaling":0.6,
			"angle":40,
			"shapes":[
				[24,18,66,-10]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("jab")
