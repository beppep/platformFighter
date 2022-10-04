extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 68
	fastEndFrame = 67
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":8,
			"start":26,
			"end":29,
			"kb":150,
			"kbscaling":0.8,
			"angle":90,
			"shapes":[
				[33,33,0,1]
			]
		},
	]

func update():
	if player.stateTimer==1:
		player.anim_sprite.play("reborn")
