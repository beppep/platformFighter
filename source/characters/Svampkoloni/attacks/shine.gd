extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = -1
	fastEndFrame = -1
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":6,
			"start":0,
			"end":1,
			"kb":200,
			"kbscaling":0.3,
			"angle":90,
			"shapes":[
				[34,34,8,0]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":4,
			"start":0,
			"end":1,
			"kb":150,
			"kbscaling":0.3,
			"angle":60,
			"shapes":[
				[44,44,8,0]
			]
		},
	]

func update(player):
	autoAttack(player)
	player._velocity *= 0.8
	if player.stateTimer==0:
		$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".shine)
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("shine")
	if player.buttons[0]:
		interrupted = true
		endAttack(player)
	elif player.buttons[3]:
		interrupted = true
		endAttack(player)
