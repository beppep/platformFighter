extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	endFrame = 36
	fastEndFrame = 26
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":14,
			"start":7,
			"end":10,
			"kb":90,
			"kbscaling":2,
			"angle":140,
			"shapes":[
				[7,17,-68,-10]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":9,
			"start":7,
			"end":17,
			"kb":60,
			"kbscaling":1,
			"angle":130,
			"shapes":[
				[27,15,-48,-10]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("bair")
	if player.is_on_floor():
		interrupted = true
