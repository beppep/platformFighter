extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 18
	fastEndFrame = 12
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":3,
			"end":6,
			"kb":60,
			"kbscaling":0.3,
			"angle":66,
			"shapes":[
				[20,20,44,18]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("jab")
