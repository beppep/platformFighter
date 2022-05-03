extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.

func _init() -> void:
	can_grabcancel=false
	endFrame = 28
	fastEndFrame = 8
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":2,
			"start":4,
			"end":5,
			"kb":30,
			"kbscaling":0.1,
			"angle":-90,
			"autolinkX":0.9,
			"shapes":[
				[40,8,0,24]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":1,
			"start":6,
			"end":7,
			"kb":50,
			"kbscaling":0.1,
			"angle":90,
			"autolinkX":0.9,
			"shapes":[
				[40,8,0,32]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer<10:
		player._velocity.y = 0
	if player.stateTimer==0:
		#$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".woosh)
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("float")
	if player.buttons[2] and player.stateTimer == 7:
		interrupted = true
		autoEndAttack(player)
		player.state=1
		player.stateTimer=-1
