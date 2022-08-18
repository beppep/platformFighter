extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 38
	fastEndFrame = 29
	hitboxes = [
		{
			"name":"earth",
			"group":1,
			"damage":12,
			"start":6,
			"end":10,
			"kb":60,
			"kbscaling":0.8,
			"angle":180-80,
			"shapes":[
				[20,20,-52,0]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":8,
			"start":19,
			"end":25,
			"kb":70,
			"kbscaling":0.8,
			"angle":25,
			"shapes":[
				[30,18,55,0]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("ftilt")
