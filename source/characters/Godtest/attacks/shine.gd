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
			"kb":150,
			"kbscaling":0.2,
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
			"kb":100,
			"kbscaling":0.2,
			"angle":60,
			"shapes":[
				[44,44,8,0]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("shine")
		player._velocity = Vector2.ZERO
	if (Input.get_action_strength("p1_shield") and player.player_id==0 or Input.get_action_strength("p2_shield") and player.player_id==1):
		interrupted = true
		endAttack(player)
	elif (Input.get_action_strength("p1_jump") and player.player_id==0 or Input.get_action_strength("p2_jump") and player.player_id==1):
		interrupted = true
		endAttack(player)
