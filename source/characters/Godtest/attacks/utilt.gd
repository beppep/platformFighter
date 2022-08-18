extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 28
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":5,
			"end":8,
			"kb":40,
			"kbscaling":0.1,
			"angle":90,
			"autolink":1,
			"shapes":[
				[25,25,0,-23]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":4,
			"start":13,
			"end":16,
			"kb":100,
			"kbscaling":1,
			"angle":88,
			"shapes":[
				[32,32,0,-23]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("utilt")
