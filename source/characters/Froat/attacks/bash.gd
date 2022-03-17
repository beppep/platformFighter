extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the script loads or somethn
func _init() -> void:
	endFrame = 35
	fastEndFrame = 27
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":15,
			"start":12,
			"end":14,
			"kb":120,
			"kbscaling":2.5,
			"angle":-70,
			"shapes":[
				[20,20,30,0]
			]
		},
		{
			"name":"1",
			"group":1,
			"damage":6,
			"start":15,
			"end":24,
			"kb":80,
			"kbscaling":0.5,
			"angle":55,
			"shapes":[
				[24,24,30,0]
			]
		},
		{
			"name":"2",
			"group":1,
			"damage":9,
			"start":12,
			"end":16,
			"kb":130,
			"kbscaling":2,
			"angle":120,
			"shapes":[
				[44,24,-70,20]
			]
		},
	]

func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("bash")
	if player.is_on_ground:
		interrupted = true
