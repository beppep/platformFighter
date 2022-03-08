extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var grabbedWall = false

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 26
	fastEndFrame = 19
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":1,
			"start":4,
			"end":5,
			"kb":20,
			"kbscaling":0.1,
			"angle":90,
			"shapes":[
				[38,38,0,-37]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":1,
			"start":6,
			"end":7,
			"kb":20,
			"kbscaling":0.1,
			"angle":90,
			"shapes":[
				[40,40,0,-37]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":4,
			"start":8,
			"end":10,
			"kb":100,
			"kbscaling":1,
			"angle":90,
			"shapes":[
				[42,42,0,-37]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("utilt")
