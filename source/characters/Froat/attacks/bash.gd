extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the script loads or somethn
func _init() -> void:
	endFrame = 34
	fastEndFrame = 24
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":13,
			"start":9,
			"end":11,
			"kb":100,
			"kbscaling":2.5,
			"angle":-70,
			"shapes":[
				[20,20,30,0]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":7,
			"start":9,
			"end":16,
			"kb":100,
			"kbscaling":0.5,
			"angle":110,
			"shapes":[
				[30,30,-10,0]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("bash")
	if player.is_on_ground:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 10
