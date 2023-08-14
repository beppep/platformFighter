extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.

func _init() -> void:
	endFrame = 30
	fastEndFrame = 15
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":2,
			"start":4,
			"end":5,
			"kb":30,
			"kbscaling":0.3,
			"angle":-90,
			"shapes":[
				[30,40,0,0]
			],
			"electric":4,
		},
		{
			"name":"1",
			"group":2,
			"damage":1,
			"start":6,
			"end":7,
			"kb":50,
			"kbscaling":0.3,
			"angle":50,
			"shapes":[
				[30,40,0,0]
			],
			"electric":4,
		},
	]

func update():
	if player.stateTimer<fastEndFrame:
		player._velocity.y = 0
	if player.stateTimer==0:
		player.anim_sprite.play("jump")
		player.anim_sprite.play("nb")
		if player.electric_charge < 10:
			player.electric_charge += 1
	if player.buttons[2] and player.direction == Vector2.ZERO and player.stateTimer == 13 and player.B_charge>0:
		player.B_charge-=1
		interrupted = true
		endAttack(false)
		player.attackWith("nb")
		player.stateTimer = -1
