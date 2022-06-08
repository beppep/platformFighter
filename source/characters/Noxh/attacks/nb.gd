extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.

func _init() -> void:
	can_grabcancel=false
	endFrame = 58
	fastEndFrame = 38
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":6,
			"start":8,
			"end":10,
			"kb":40,
			"kbscaling":0.3,
			"angle":80,
			"autolinkX":0.5,
			"autolinkY":0.5,
			"shapes":[
				[34,54,40,0]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":7,
			"start":28,
			"end":30,
			"kb":100,
			"kbscaling":1,
			"angle":-70,
			"shapes":[
				[24,44,38,0]
			]
		},
	]

func update(player):
	autoAttack(player)
	player._velocity.x *= 0.9
	player._velocity.y *= 0.85
	player._velocity.y -= 50
	if player.stateTimer==0:
		player.anim_sprite.play("nb")
	if not player.buttons[2] and player.stateTimer==26:
		interrupted = true
