extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	endFrame = 29
	fastEndFrame = 20
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":2,
			"start":4,
			"end":6,
			"kb":20,
			"kbscaling":0.1,
			"angle":90,
			"shapes":[
				[30,16,48,-8]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":6,
			"start":8,
			"end":11,
			"kb":80,
			"kbscaling":0.3,
			"angle":130,
			"shapes":[
				[34,20,48,-8]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("ftilt")

func onHit(name, target, shielded=false):
	if name=="1" and not shielded:
		endFrame = fastEndFrame
